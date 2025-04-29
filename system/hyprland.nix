{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
    portalPackage = pkgs.xdg-desktop-portal-gtk;
  };

  xdg.portal = with pkgs; {
    extraPortals = [xdg-desktop-portal-hyprland];
    configPackages = [hyprland];
    xdgOpenUsePortal = true;
  };
}
