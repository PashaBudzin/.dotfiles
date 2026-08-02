{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
    portalPackage = pkgs.xdg-desktop-portal-gtk;
  };

  xdg.portal = {
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [ pkgs.hyprland ];
    xdgOpenUsePortal = true;
  };

  environment.systemPackages = with pkgs; [
    mesa
    libglvnd
    libdrm
    brightnessctl
  ];
}
