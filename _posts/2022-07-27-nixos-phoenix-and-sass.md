---
date: 2022-07-27 12:00
title: NixOS, Phoenix and Sass
categories: [computing]
tags: [linux, nixos, elixir]
---

[Elixir's](https://elixir-lang.org/) web application framework, [Phoenix](https://www.phoenixframework.org/), is moving away from needing a dependency on [Node](https://nodejs.org/en/) to make projects easier to maintain and thing in general just a bit simpler. The most recent step towards this was the release of a [Tailwind Elixir library](https://github.com/phoenixframework/tailwind) which installs and runs a standalone copy of the Tailwind CLI.

> If you don't need [Alpine.js](https://alpinejs.dev/) then you can probably be Node-free in your Phoenix projects right now.

A really good guide to incorporating Tailwind into a Phoenix project is [Adding Tailwind CSS to Phoenix 1.6](https://pragmaticstudio.com/tutorials/adding-tailwind-css-to-phoenix) by [Mike Clark](https://twitter.com/clarkware), one half of the excellent Pragmatic Studio team.

About half way through that tutorial he covers Nested CSS with DartSass which relies on the [DartSass Elixir Library](https://github.com/CargoSense/dart_sass) which installs and runs a dart-sass implementation.

Unfortunately the pre-built binary of dart-sass which gets installed into your `_build` folder is a dynamic binary and dynamic binaries don't work on [NixOS](https://nixos.org/) because it does not conform to the [Filesystem Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard) of Linux.

> A dynamic binary loads code from external binaries (.so files) while in a static binary any library code is included in the binary at build time (from static .a libraries).

Fortunately there are various solutions to this and the one I will cover uses [nix-ld](https://github.com/Mic92/nix-ld).

The project's README does a good job of explaining how nix-ld works its magic and how you can use it so I'll just cover the steps I followed to get DartSass working for my Phoenix project.

I use a [`nix-shell`](https://nixos.org/manual/nix/stable/command-ref/nix-shell.html) to create a development environment for my Phoenix project. Here is my `shell.nix` file:

```
{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  inherit (lib) optional optionals;

  erlang = beam.interpreters.erlangR24;
  elixir = beam.packages.erlangR24.elixir_1_13;
  nodejs = nodejs-14_x;

  sass_version = "1.53.0";
  sass_src = fetchurl {
    url = "https://github.com/sass/dart-sass/releases/download/${sass_version}/dart-sass-${sass_version}-linux-x64.tar.gz";
    sha256 = "MXSHrU96WHQMNgxKPPyHdIl8+wXI2KL7cNvDsWZoZKI=";
  };

in

mkShell {
  buildInputs = [
    cacert
    erlang
    elixir
    file
    nodejs
    rebar3
    inotify-tools
  ];

  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
    stdenv.cc
  ];
  NIX_LD = builtins.readFile "${stdenv.cc}/nix-support/dynamic-linker";

  shellHook = ''
    # this allows mix to work on the local directory
    mkdir -p .nix-mix
    mkdir -p .nix-hex
    export MIX_HOME=$PWD/.nix-mix
    export HEX_HOME=$PWD/.nix-hex
    export PATH=$MIX_HOME/bin:$PATH
    export PATH=$HEX_HOME/bin:$PATH
    export LANG=en_US.UTF-8
    export ERL_AFLAGS="-kernel shell_history enabled"

    if [ ! -d .sass ]; then
      echo "Unpack sass..."
      mkdir .sass
      tar -C .sass -xf ${sass_src}
    fi
    export LD_LIBRARY_PATH=$PWD/.sass/dart-sass/
    export MIX_SASS_PATH=$PWD/.sass/dart-sass/sass
    export MIX_SASS_VERSION=${sass_version}
  '';
}
```

Breaking out the DartSass elements...

We define the version, URL and SHA-256 hash for the DartSass binary file we are going to download and use.

> The lazy way to find hashes is to set them to 52 zeros and then NixOS will show an error saying that the SHA is invalid and show you what the file's actual SHA is.

```
  sass_version = "1.53.0";
  sass_src = fetchurl {
    url = "https://github.com/sass/dart-sass/releases/download/${sass_version}/dart-sass-${sass_version}-linux-x64.tar.gz";
    sha256 = "MXSHrU96WHQMNgxKPPyHdIl8+wXI2KL7cNvDsWZoZKI=";
  };

```

DartSass only links to standard libraries so we just need to use `stdenv.cc` to shim things.

> If you download a pre-built binary and then run `ldd sass-linux-x64` you will see the libraries that the program needs.

```
  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
    stdenv.cc
  ];
  NIX_LD = builtins.readFile "${stdenv.cc}/nix-support/dynamic-linker";
```

In the `shellHook` we store our downloaded binary if it is not already there. I store it in a folder called `.sass` which can be easily included in my `.gitignore` file. The path of the folder containing the binary is then stored in the `LD_LIBRARY_PATH` environmental variable.

```
  if [ ! -d .sass ]; then
    echo "Unpack sass..."
    mkdir .sass
    tar -C .sass -xf ${sass_src}
  fi
  export LD_LIBRARY_PATH=$PWD/.sass/dart-sass/
```

And that is all that is needed to shim the DartSass binary so that it will run under NixOS.

However two other environmental variables are set which then help with our Phoenix configuration:

```
  export MIX_SASS_PATH=$PWD/.sass/dart-sass/sass
  export MIX_SASS_VERSION=${sass_version}
```

The first is the path to the `sass` executable file. The second is the version of DartSass we have used. These allow us to configure DartSass in the `config/config.exs` file in a way which allows the same code to be used in NixOS or another distribution:

```
# Configure DartSass
config :dart_sass,
  version: System.get_env("MIX_SASS_VERSION", "1.49.11"),
  path: System.get_env("MIX_SASS_PATH"),
  default: [
    args: ~w(css/app.scss ../priv/static/assets/app.tailwind.css),
    cd: Path.expand("../assets", __DIR__)
  ]
```

We set the `version` to the one we downloaded or, if the environmental variable does not exist, we use the version that the DartSass Elixir Library uses. This is probably the version listed in [the DartSass documentation](https://hexdocs.pm/dart_sass/DartSass.html#module-profiles).

We set the `path` to the one we defined in the environmental variable but if that does not exist then the config will automatically fall back on the default location DartSass uses which is in the `_build` folder.

And that's it. You don't need to fall back on the Node version of Sass (even if you are using Node for something like Alpine.js) and your Phoenix project will now work on both your NixOS machines in a `nix-shell` environment or on any other distribution where you don't need to worry about dynamic binaries.
