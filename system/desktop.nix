{pkgs, ...}: {
  services.xserver = {
    enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    desktopManager.gnome = {
      # enable fractional scaling
      extraGSettingsOverridePackages = [pkgs.mutter];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };
  };

  environment.sessionVariables.OS_OZONE_WL = "1";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.sessionVariables.GTK_USE_PORTAL = "1";
  environment.sessionVariables.NIXOS_GTK_USE_PORTAL = "1";

  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";

  xdg.autostart.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal
    ];
  };
}
