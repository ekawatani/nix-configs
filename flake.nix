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
      # Available hosts
      hosts = {
        core = {
          name = "core";
          createNixOs = true;
          createHomeManager = true;
        };
        skybay = {
          name = "skybay";
          createNixOs = true;
          createHomeManager = true;
        };
        wsl = {
          name = "wsl";
          createNixOs = false;
          createHomeManager = true;
        };
      };

      # Settings common across all hosts and users
      settings = import ./settings.nix;

      # A function to create NixOS configurations for different hosts
      createNixOsConfig =
        {
          hostname,
          system ? "x86_64-linux",
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            ./modules/features.nixos.nix
            ./hosts/${hostname}/configuration.nix
            catppuccin.nixosModules.catppuccin
          ];
          specialArgs = {
            inherit hostname;
            inherit settings;
          };
        };

      # A function to create Home Manager configurations for different users
      createHomeManagerConfig =
        {
          hostname,
          system ? "x86_64-linux",
        }:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./modules/features.home-manager.nix
            ./home/home.nix
            catppuccin.homeModules.catppuccin
          ];
          specialArgs = {
            inherit hostname;
            inherit settings;
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

      homeConfigurations = {
        core = createHomeManagerConfig {
          hostname = "core";
        };
        skybay = createHomeManagerConfig {
          hostname = "skybay";
        };
        wsl = createHomeManagerConfig {
          hostname = "wsl";
        };
      };
    };
}
