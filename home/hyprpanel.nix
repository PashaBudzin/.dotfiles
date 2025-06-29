{ inputs, userSettings, ... }: {
  programs.hyprpanel = {
    # Enable the module.
    # Default: false
    enable = true;

    # Add '/nix/store/.../hyprpanel' to your
    # Hyprland config 'exec-once'.
    # Default: false
    hyprland.enable = true;

    # Fix the overwrite issue with HyprPanel.
    # See below for more information.
    # Default: false
    overwrite.enable = true;

    # Import a theme from './themes/*.json'.
    # Default: ""

    # Override the final config with an arbitrary set.
    # Useful for overriding colors in your selected theme.
    # Default: {}
    # override = {
    #   theme.bar.menus.text = "#123ABC";
    # };

    # Configure bar layouts for monitors.
    # See 'https://hyprpanel.com/configuration/panel.html'.
    # Default: null
    # Configure and theme almost all options from the GUI.

    # Options that require '{}' or '[]' are not yet implemented,
    # except for the layout above.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    settings = {
      layout = {

        bar.layouts = {
          "0" = {
            left = [ "dashboard" "workspaces" "systray" "notifications" ];
            middle = [ "media" ];
            right = [ "volume" "bluetooth" "battery" "clock" ];
          };
        };
      };
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      bar.customModules.cava.showIcon = false;

      bar.bluetooth.label = false;
      bar.network.label = false;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard = {

      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;
      theme.bar.buttons.radius = "10em";

      theme.font = {
        name = userSettings.font;
        size = "16px";
      };
      theme.bar.buttons.style = "split";

    };
  };
}
