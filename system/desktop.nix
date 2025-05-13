{ pkgs, ... }: {
  services.xserver = {
    enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    desktopManager.gnome = {
      # enable fractional scaling
      extraGSettingsOverridePackages = [ pkgs.mutter ];
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
      xdg-desktop-portal-termfilechooser
    ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "app.zen_browser.zen.desktop";
      "application/pdf" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/https" = "app.zen_browser.zen.desktop";

      "application/x-shellscript" = "kitty.desktop";
      "x-scheme-handler/terminal" = "kitty.desktop";
      "x-terminal-emulator" = "kitty.desktop";

      "image/jpeg" = "org.gnome.eog.desktop";
      "image/png" = "org.gnome.eog.desktop";
      "image/gif" = "org.gnome.eog.desktop";
      "image/webp" = "org.gnome.eog.desktop";

      "video/mp4" = "org.gnome.Totem.desktop";
      "video/x-matroska" = "org.gnome.Totem.desktop";
      "video/webm" = "org.gnome.Totem.desktop";

      "application/zip" = "org.gnome.FileRoller.desktop";
      "application/x-tar" = "org.gnome.FileRoller.desktop";
      "application/x-bzip" = "org.gnome.FileRoller.desktop";
      "application/x-bzip2" = "org.gnome.FileRoller.desktop";
      "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
      "application/x-rar" = "org.gnome.FileRoller.desktop";
    };
  };
}
