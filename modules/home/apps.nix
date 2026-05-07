{ pkgs, inputs, ... }:
{
  programs.zen-browser.enable = true;

  home.packages = with pkgs; [
    pear-desktop
    inputs.helium.packages.${system}.default
    materialgram
    mangohud
    libresprite
    pied
    tdf
  ];

  xdg.mimeApps = {
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

  home.sessionVariables = {
    BROWSER = "zen-beta";
  };
}
