# General Notes

To setup Jekyll on NixOS use:

https://woutswinkels.github.io/posts/Run-Jekyll-locally-on-NixOS/

That builds upon:

https://matthewrhone.dev/jekyll-in-nixos

Ruby Gems can be found at:

https://rubygems.org/gems/

If the `Gemfile` is updated then run:

`nix-shell -p bundler -p bundix --run 'bundler update; bundler lock; bundler package --no-install --path vendor; bundix; rm -rf vendor'`

