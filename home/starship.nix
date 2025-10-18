{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    catppuccin.enable = true;

    settings = {
      format = pkgs.lib.concatStrings ([
        "$username"
        "$hostname"
        "$git_branch"
        "$cmd_duration"
        "$all"
        "$directory"
        "\n"
        "$character"
      ]);

      cmd_duration = {
        format = "\\([$duration]($style)\\)";
      };

      directory = {
        truncation_length = 0;
        truncate_to_repo = false;
        format = "[]($style) [$path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };

      git_status = {
        disabled = true;
      };

      hostname = {
        format = "[$ssh_symbol$hostname](cyan dimmed) ";
        ssh_only = false;
      };

      username = {
        format = "[$user@](cyan dimmed)";
        show_always = true;
      };
    };
  };
}
