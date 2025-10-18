{
  config,
  lib,
  features,
  ...
}:

{
  services = {
    fal2ban = {
      enable = features.fail2ban;
    };
  };
}
