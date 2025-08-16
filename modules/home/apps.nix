{ config, pkgs, lib, ... }:

{
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

  config = lib.mkIf (config.apps.zen.enable or config.apps.zen.setDefault) {
    programs.zen-browser.enable = true;
  } // {
    home.packages = lib.concatLists [
      (lib.mkIf config.apps.youtubeMusic [ pkgs.youtube-music ])
      (lib.mkIf config.apps.materialgram [ pkgs.materialgram ])
      (lib.mkIf config.apps.mangohud [ pkgs.mangohud ])
      (lib.mkIf config.apps.libresprite [ pkgs.libresprite ])
      (lib.mkIf config.apps.pied [ pkgs.pied ])
      (lib.mkIf config.apps.tdf [ pkgs.tdf ])
      (lib.mkIf config.apps.readest [ pkgs.readest ])
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
