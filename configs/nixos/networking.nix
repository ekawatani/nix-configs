{
  config,
  lib,
  ...
}:

{
  networking.networkmanager = {
    enable = config.features.networking.enabled;
  };
}
