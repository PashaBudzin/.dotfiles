{ config, pkgs, lib, ... }:

let zenEnabled = config.apps.zen.enable or config.apps.zen.setDefault;
in {
  options = {
    apps = {
      zen = {
        enable = lib.mkEnableOption "Enable Zen Browser.";
        setDefault = lib.mkEnableOption
          "Set Zen as default for HTML/XML/HTTP MIME types and BROWSER env variable.";
      };

      youtubeMusic = lib.mkEnableOption "Install YouTube Music app.";
      materialgram = lib.mkEnableOption "Install Materialgram app.";
      mangohud = lib.mkEnableOption "Install MangoHud app.";
      libresprite = lib.mkEnableOption "Install Libresprite app.";
      pied = lib.mkEnableOption "Install Pied app.";
      tdf = lib.mkEnableOption "Install TDF app.";
      readest = lib.mkEnableOption "Install Readest app.";
    };
  };

  config = {
    programs.zen-browser.enable = zenEnabled;

    home.packages = lib.concatLists [
      (lib.mkIf config.apps.youtubeMusic [ pkgs.youtube-music ]).content
      (lib.mkIf config.apps.materialgram [ pkgs.materialgram ]).content
      (lib.mkIf config.apps.mangohud [ pkgs.mangohud ]).content
      (lib.mkIf config.apps.libresprite [ pkgs.libresprite ]).content
      (lib.mkIf config.apps.pied [ pkgs.pied ]).content
      (lib.mkIf config.apps.tdf [ pkgs.tdf ]).content
      (lib.mkIf config.apps.readest [ pkgs.readest ]).content
    ];

    xdg.mimeApps = lib.mkIf config.apps.zen.setDefault {
      enable = true;
      defaultApplications = {
        "application/xhtml+xml" = "zen-beta.desktop";
        "text/html" = "zen-beta.desktop";
        "text/xml" = "zen-beta.desktop";
        "x-scheme-handler/ftp" = "zen-beta.desktop";
        "x-scheme-handler/http" = "zen-beta.desktop";
        "x-scheme-handler/https" = "zen-beta.desktop";
      };
    };

    home.sessionVariables =
      lib.mkIf config.apps.zen.setDefault { BROWSER = "zen"; };
  };
}
