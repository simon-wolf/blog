with (import <nixpkgs> {}); let
  env = bundlerEnv {
    name = "Simon Wolf's Blog";
    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in
  stdenv.mkDerivation {
    name = "Simon Wolf's Blog";
    buildInputs = [env ruby];

    shellHook = ''
#      exec ${env}/bin/jekyll serve --watch
      alias preview="jekyll serve --future --drafts --watch"

      echo "Run 'preview'"
    '';
  }

