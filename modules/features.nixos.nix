{ lib, config, ... }:

{
  options.features = {
    server = lib.mkOption {
      description = "Enable server-related features";
      type = lib.types.bool;
      default = false;
    };

    docker = lib.mkOption {
      description = "Docker feature configuration";
      type = lib.types.submodule {
        options = {
          enabled = lib.mkOption {
            description = "Enable Docker support";
            type = lib.types.bool;
          };
          # Add more fields here later if needed
        };
      };
    };

    fail2ban = lib.mkOption {
      description = "Fail2Ban feature configuration";
      type = lib.types.submodule {
        options = {
          enabled = lib.mkOption {
            description = "Enable Fail2Ban";
            type = lib.types.bool;
          };
        };
      };
    };

    networking = lib.mkOption {
      description = "Networking feature configuration";
      type = lib.types.submodule {
        options = {
          enabled = lib.mkOption {
            description = "Enable networking features";
            type = lib.types.bool;
          };
        };
      };
    };

    openssh = lib.mkOption {
      description = "OpenSSH feature configuration";
      type = lib.types.submodule {
        options = {
          enabled = lib.mkOption {
            description = "Enable OpenSSH";
            type = lib.types.bool;
          };
        };
      };
    };
  };

  config = {
    features = {
      docker.enabled = lib.mkDefault config.features.server;
      fail2ban.enabled = lib.mkDefault config.features.server;
      networking.enabled = lib.mkDefault false;
      openssh.enabled = lib.mkDefault config.features.server;
    };
  };
}
