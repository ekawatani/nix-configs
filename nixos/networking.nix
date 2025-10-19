{
  lib,
  features,
  ...
}:

{
  networking.networkmanager = {
    enable = lib.mkDefault features.networking;
  };
}
