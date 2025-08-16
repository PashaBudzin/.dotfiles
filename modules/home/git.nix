{ config, lib, pkgs, userSettings, ... }:

{
  options.dev.git = lib.mkEnableOption "Enable Git and GitHub setup.";

  config = lib.mkIf config.dev.git {
    programs.git = {
      enable = true;
      userName = userSettings.name;
      userEmail = userSettings.email;
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
    };

    programs.gh.enable = true;
  };
}
