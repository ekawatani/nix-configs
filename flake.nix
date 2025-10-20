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
            ./configs/home/home.nix
            catppuccin.homeModules.catppuccin
          ];
          extraSpecialArgs = {
            inherit hostname;
            inherit settings;
          };
        };

      # Create NixOS configurations for hosts where nixos = true
      nixosHosts = nixpkgs.lib.filterAttrs (_: host: host.nixos) settings.hosts;
      # Create Home Manager configurations for hosts where home-manager = true
      homeManagerHosts = nixpkgs.lib.filterAttrs (_: host: host."home-manager") settings.hosts;
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
