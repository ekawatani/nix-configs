# My NixOS Configurations

To deploy this to a remote server, run:

> nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./nixos/hosts/<hostname>/hardware-configuration.nix --flake .#<hostname> --target-host root@<server address> --build-on remote

Testing flake locally

> nix build .#nixosConfigurations.<hostname>.config.system.build.toplevel --no-write-lock-file --refresh
