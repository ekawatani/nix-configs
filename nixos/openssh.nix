{
  config,
  lib,
  ...
}:

{
  services = {
    openssh = {
      enable = config.features.openssh.enabled;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
