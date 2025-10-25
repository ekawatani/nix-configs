{
  # Defines the main username to be used in the configurations.
  username = "eigo";

  # Defines the hosts to manage.
  # For each host:
  # nixos - Whether to create a NixOS configuration for this host.
  # home-manager - Whether to create a Home Manager configuration for this host.
  hosts = {
    core = {
      type = "nixos";
    };
    skybay = {
      type = "nixos";
    };
    wsl = {
      type = "nix";
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
