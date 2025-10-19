{
  config,
  lib,
  ...
}:

{
  services = {
    fail2ban = {
      enable = config.features.fail2ban.enabled;
    };
  };
}
