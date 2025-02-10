{ pkgs, ... }:

{
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

}
