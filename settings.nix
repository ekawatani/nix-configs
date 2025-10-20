{
  # Defines the main username to be used in the configurations.
  username = "eigo";

  # Defines the hosts to manage.
  # For each host:
  # nixos - Whether to create a NixOS configuration for this host.
  # home-manager - Whether to create a Home Manager configuration for this host.
  hosts = {
    core = {
      nixos = true;
      home-manager = true;
    };
    skybay = {
      nixos = true;
      home-manager = true;
    };
    wsl = {
      nixos = false;
      home-manager = true;
    };
  };

  # Defines GitHub accounts to be used in the configurations.
  github-accounts = [
    {
      username = "ekawatani";
      email = "e.k.dev@outlook.com";
    }
    {
      username = "EddyNordica";
      email = "eddy.nordica@outlook.com";
    }
  ];
}
