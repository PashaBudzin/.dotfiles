{ config, lib, userSettings, ... }:

{
  options.dev.git = lib.mkEnableOption "Enable Git and GitHub setup.";

  config = lib.mkIf config.dev.git {
    programs.git = {
      enable = true;
      userName = userSettings.name;
      userEmail = userSettings.email;
      extraConfig = { init.defaultBranch = "main"; };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
