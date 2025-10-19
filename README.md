# My NixOS Configurations

To deploy this to a remote server, run:

> nix run nixpkgs#nixos-anywhere -- --flake .#<hostname> --generate-hardware-config nixos-generate-config ./hosts/<hostname>/hardware-configuration.nix <server address>

Testing flake locally

> nix build .#nixosConfigurations.<hostname>.config.system.build.toplevel --no-write-lock-file --refresh
