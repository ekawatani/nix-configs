{
  config,
  lib,
  features.openssh,
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
