{
  features = {
    nixos = {
      docker = false;
      fail2ban = true;
      networking = true;
      openssh = true;
    };

    home-manager = {
      development = true;
    };
  };
}
