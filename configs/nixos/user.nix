{
  config,
  lib,
  settings,
  ...
}:

{
  users.users = {
    ${settings.username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ] ++ lib.optional config.features.networking.enabled [ "networkmanager" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFr0b+CZTAToYtLQaoDQnk4q+n2dp1aaSJT4GE7mSJ0w eigo@wsl-core"
      ];
    };
  };
}
