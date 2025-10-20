{ lib, config, ... }:

{
  options.features = {
    development = lib.mkOption {
      description = "Enable development-related features";
      type = lib.types.bool;
      default = false;
    };

    vscode = lib.mkOption {
      description = "VSCode configuration";
      type = lib.types.submodule {
        options = {
          enabled = lib.mkOption {
            description = "Enables VSCode configuration";
            type = lib.types.bool;
          };
        };
      };
    };
  };

  config = {
    features = {
      vscode.enabled = lib.mkDefault config.features.development;
    };
  };
}
