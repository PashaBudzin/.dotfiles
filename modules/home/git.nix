{ config, lib, pkgs, userSettings, ... }:

{
  options.dev.git = lib.mkEnableOption "Enable Git and GitHub setup.";

  config = lib.mkIf config.dev.git {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = userSettings.name;
          email = userSettings.email;
        };
        init.defaultBranch = "main";
        credential.helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
    };

    programs.gh.enable = true;
  };
}
