{
  lib,
  features,
  ...
}:

{
  services = {
    openssh = {
      enable = features.openssh;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
  };
}
