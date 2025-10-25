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
            ./nixos/hosts/${hostname}/configuration.nix
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit hostname;
                inherit settings;
              };

              home-manager.users.${settings.username} = {
                imports = [
                  ./modules/features.home-manager.nix
                  ./home-manager/hosts/${hostname}/home.nix
                ];
              };
            }
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
            ./home-manager/hosts/${hostname}/home.nix
            catppuccin.homeModules.catppuccin
          ];
          extraSpecialArgs = {
            inherit hostname;
            inherit settings;
          };
        };

      nixosHosts = nixpkgs.lib.filterAttrs (_: host: host.type == "nixos") settings.hosts;
      homeManagerHosts = nixpkgs.lib.filterAttrs (_: host: host.type == "nix") settings.hosts;
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs (
        name: host: createNixOsConfig { hostname = name; }
      ) nixosHosts;

      homeConfigurations = nixpkgs.lib.mapAttrs (
        name: host: createHomeManagerConfig { hostname = name; }
      ) homeManagerHosts;
    };
}
