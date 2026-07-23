{ pkgs, userSettings, ... }:
let
  hyprDir = ../../symlinks/hypr;
in
{
  xdg.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
    slurp
    grim
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };

  services.hypridle.enable = true;

  home.file.".config/hypr" = {
    source = hyprDir;
    recursive = true;
  };
}
