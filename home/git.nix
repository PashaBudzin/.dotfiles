{ userSettings, ... }: {
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
}
