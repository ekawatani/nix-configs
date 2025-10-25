{
  # Defines the main username to be used in the configurations.
  username = "eigo";

  # Defines available hosts.
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
