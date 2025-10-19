{
  lib,
  features,
  ...
}:

{
  services = {
    fail2ban = {
      enable = features.fail2ban;
    };
  };
}
