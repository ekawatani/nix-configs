{
  imports = [
    ./features.default.nix
  ];

  features = {
    nixos = {
      docker = true;
      networking = false;
    };
    home-manager = {
      development = false;
    }
  };
}
