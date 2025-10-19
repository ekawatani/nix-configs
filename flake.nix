{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixos-wsl = {
    #   url = "github:nix-community/nixos-wsl";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      catppuccin,
      disko,
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
          pkgs = import nixpkgs { inherit system; };
          features = pkgs.callPackage ./hosts/${hostname}/features.nix { };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            ./hosts/${hostname}/configuration.nix
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${settings.username} = {
                imports = [
                  ./home/home.nix
                  catppuccin.homeModules.catppuccin
                ];
              };
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
