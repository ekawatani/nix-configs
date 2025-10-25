{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "exa --icons -F -H --group-directories-first --git";
    };
  };
}
