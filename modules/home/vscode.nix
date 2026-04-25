{ pkgs, config, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = true;

    userSettings = {
      "workbench.colorTheme" = "Dynamic Base16 DankShell (Dark)";
      "editor.fontLigatures" = true;
      "editor.fontFamily" = "Maple Mono NF";
      "editor.fontSize" = 14;
      "editor.tabSize" = 4;
      "editor.rulers" = [ 80 ];

      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
      "files.autoSaveWhenNoErrors" = true;

      "editor.formatOnSave" = true;

      "workbench.sideBar.location" = "right";
      "workbench.layoutControl.enabled" = false;
      "workbench.navigationControl.enabled" = false;
      "workbench.activityBar.location" = "hidden";
      "workbench.editor.editorActionsLocation" = "hidden";

      "window.commandCenter" = false;
      "window.titleBarStyle" = "native";
      "window.customTitleBarVisibility" = "never";
      "window.newWindowDimensions" = "maximized";
      "window.menuBarVisibility" = "compact";
      "window.restoreFullscreen" = true;
      "window.menuStyle" = "custom";

      "vim.leader" = " ";
      "vim.useSystemClipboard" = true;
      "vim.handleKeys" = { "<C-b>" = false; };
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          before = [ "<Space>nj" ];
          commands = [ "notebook.focusNextEditor" ];
        }
        {
          before = [ "<Space>nk" ];
          commands = [ "notebook.focusPreviousEditor" ];
        }
        {
          before = [ "<tab>" ];
          commands = [ "workbench.action.nextEditor" ];
        }
        {
          before = [ "<S-tab>" ];
          commands = [ "workbench.action.previousEditor" ];
        }
        {
          before = [ "<Space>nc" ];
          commands = [ "notebook.cell.insertBelow" ];
        }
        {
          before = [ "<Space>ne" ];
          commands = [ "notebook.cell.execute" ];
        }
        {
          before = [ "<Space>na" ];
          commands = [ "notebook.executeAllCells" ];
        }
        {
          before = [ "<Space>e" ];
          commands = [ "editor.action.showHover" ];
        }
        {
          before = [ "<C-p>" ];
          commands = [ "code-telescope.fuzzy.file" ];
        }
        {
          before = [ "K" ];
          commands = [ "editor.action.showHover" ];
        }
      ];

      "terminal.integrated.defaultProfile.linux" = "bash";
    };
  };

  home.file."${config.xdg.configHome}/VSCodium/User/settings.json".force = true;
}
