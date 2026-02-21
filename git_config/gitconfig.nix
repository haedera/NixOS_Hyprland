{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    config = {
      user = {
        name = "haedera";
        email = "haderue@pm.me";
      };

      core = {
        editor = "nvim";
      };

      init = {
        defaultBranch = "master"; # oder "main"
      };

      pull = {
        ff = "only";
      };
    };
  };
}
