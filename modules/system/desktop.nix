{ config, pkgs, lib, ... }:

{
  options = {
    desktop.gnome = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable GNOME desktop environment.";
    };

    desktop.xserver = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable the X server.";
    };

    desktop.waylandEnvironmentVariables = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable Wayland environment variables.";
    };

    desktop.gdm = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable GDM display manager.";
    };

    desktop.gtkPortals = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable GTK portals.";
    };
  };

  config = lib.mkIf config.desktop.gnome {
    services.xserver.enable = config.desktop.xserver;

    services.displayManager.gdm.enable = config.desktop.gdm;

    services.desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };

    environment.sessionVariables = lib.mkMerge [
      (lib.mkIf config.desktop.waylandEnvironmentVariables {
        OS_OZONE_WL = "1";
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
      })
      (lib.mkIf config.desktop.gtkPortals {
        GTK_USE_PORTAL = "1";
        NIXOS_GTK_USE_PORTAL = "1";
      })
    ];

    xdg.autostart.enable = true;

    xdg.portal = lib.mkIf config.desktop.gtkPortals {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal ];
    };
  };
}
