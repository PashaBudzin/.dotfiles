{ config, pkgs, lib, ... }:

{
  options = {
    desktop.hyprland = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable Hyprland.";
    };

    hyprland.portals = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable XDG portals for Hyprland.";
    };
  };

  config = {
    programs.hyprland = lib.mkIf config.desktop.hyprland {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
      portalPackage = pkgs.xdg-desktop-portal-gtk;
    };

    xdg.portal = lib.mkIf config.hyprland.portals {
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      configPackages = [ pkgs.hyprland ];
      xdgOpenUsePortal = true;
    };

    environment.systemPackages =
      lib.mkIf config.desktop.hyprland (with pkgs; [ mesa libglvnd libdrm ]);
  };
}
