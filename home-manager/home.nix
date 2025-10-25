{
  config,
  pkgs,
  lib,
  hostname,
  settings,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = settings.username;
  home.homeDirectory = "/home/${settings.username}";

  imports = [
    ./bash.nix
    ./direnv.nix
    ./git.nix
    ./starship.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.activation = {
    #  Creates git directories.
    init = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # Make sure the .config directory exists.
      mkdir -p ~/.config

      # Creates lines of mkdir commands for each github accounts.
      ${builtins.concatStringsSep "\n" (
        builtins.map (account: "mkdir -p ~/projects/${account.username}") settings.github-accounts
      )}
    '';
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/just/" = {
      source = ./just;
    };

    ".justfile" = {
      source = ./just/justfile;
    };
  };

  home.packages =
    with pkgs;
    [
      # Utils
      #ripgrep # recursively searches directories for a regex pattern
      eza
      fzf
      just

      # Nix
      nixfmt-rfc-style
      nix-direnv

      # System tools
      gotop

      # Misc.
      neofetch
      which
    ]
    ++ lib.optional config.features.development [
      node2nix
    ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/eigo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    NIX_HOSTNAME = hostname;
  };

  # home.sessionPath = [
  #   "./bin"
  # ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
