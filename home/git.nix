{
  config,
  pkgs,
  settings,
  ...
}:

{
  programs.git = {
    enable = true;

    aliases = {
      # branch
      br = "branch";
      brd = "branch -D";

      # checkout
      co = "checkout";
      cob = "checkout -b";

      # commit
      cm = "commit";
      cmm = "commit -m";
      amend = "commit --amend";

      # diff
      d = "diff";

      # log

      # merge
      squash = "merge --squash";

      # status
      st = "status";
    };

    extraConfig = {
      # core = {
      #   autocrlf = "input";
      # };
      # branch = {
      #   autosetupmerge = true;
      # };
      difftool = {
        prompt = "false";
      };
      init = {
        defaultBranch = "main";
      };
      web = {
        browser = "microsoft-edge";
      };
    };

    includes = builtins.map (account: {
      contents = {
        user = {
          name = account.username;
          email = account.email;
        };
      };

      condition = "gitdir:~/projects/${account.username}/";
    }) settings.github-accounts;
  };
}
