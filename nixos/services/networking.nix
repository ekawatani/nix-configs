{
  config,
  pkgs,
  features,
  ...
}:

{
  networking.networkmanager = {
    enable = features.networkmanager;
  };
}
