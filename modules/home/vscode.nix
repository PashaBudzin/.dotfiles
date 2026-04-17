{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    userSettings = {
      "editor.fontSize" = 14;
      "editor.tabSize" = 4;
      "editor.formatOnSave" = true;

      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;

      "terminal.integrated.defaultProfile.linux" = "bash";
    };
  };
}
