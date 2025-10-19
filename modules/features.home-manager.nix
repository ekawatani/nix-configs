{ lib, config, ... }:

{
  options.features = {
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
      vscode.enabled = false;
    };
  };
}
