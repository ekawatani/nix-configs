{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    # nixos-wsl = {
    #   url = "github:nix-community/nixos-wsl";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      settings = import ./settings.nix;
      createNixOsConfig =
        {
          hostname,
          system ? "x86_64-linux",
          modules ? [ ],
        }:
        let
          features = import ./hosts/${hostname}/features.nix;
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal-combined.nix"
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${settings.username} = import ./home/home.nix;
              home-manager.extraSpecialArgs = {
                inherit hostname;
                inherit settings;
                features = features.home-manager;
              };
            }
          ]
          ++ modules;
          specialArgs = {
            inherit hostname;
            inherit settings;
            features = features.nixos;
          };
        };
    in
    {
      nixosConfigurations = {
        core = createNixOsConfig {
          hostname = "core";
        };
        skybay = createNixOsConfig {
          hostname = "skybay";
        };
        # wsl = createNixOsConfig {
        #   hostname = "wsl";
        #   system = "x86_64-windows";
        # }
      };
    };
}
