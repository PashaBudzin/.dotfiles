{ pkgs, lib, ... }: {
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = { num-workspaces = 9; };

    "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };

    "org/gnome/desktop/wm/keybindings" = {
      move-to-workspace-1 = [ "<Super><Shift>1" ];
      switch-to-application-1 = [ ];
      switch-to-workspace-1 = [ "<Super>1" ];

      move-to-workspace-2 = [ "<Super><Shift>2" ];
      switch-to-application-2 = [ ];
      switch-to-workspace-2 = [ "<Super>2" ];

      move-to-workspace-3 = [ "<Super><Shift>3" ];
      switch-to-application-3 = [ ];
      switch-to-workspace-3 = [ "<Super>3" ];

      move-to-workspace-4 = [ "<Super><Shift>4" ];
      switch-to-application-4 = [ "<Alt>4" ];
      switch-to-workspace-4 = [ "<Super>4" ];

      move-to-workspace-5 = [ "<Super><Shift>5" ];
      switch-to-application-5 = [ "<Alt>5" ];
      switch-to-workspace-5 = [ "<Super>5" ];

      move-to-workspace-6 = [ "<Super><Shift>6" ];
      switch-to-application-6 = [ "<Alt>6" ];
      switch-to-workspace-6 = [ "<Super>6" ];

      move-to-workspace-7 = [ "<Super><Shift>7" ];
      switch-to-application-7 = [ ];
      switch-to-workspace-7 = [ "<Super>7" ];

      move-to-workspace-8 = [ "<Super><Shift>8" ];
      switch-to-application-8 = [ ];
      switch-to-workspace-8 = [ "<Super>8" ];

      move-to-workspace-9 = [ "<Super><Shift>9" ];
      switch-to-application-9 = [ ];
      switch-to-workspace-9 = [ "<Super>9" ];

      close = [ "<Super>c" ];

      toggle-fullscreen = [ "<Super>f" ];

      minimize = [ ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
      {
        name = "open terminal";
        command = "kitty";
        binding = "<Super>q";
      };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      "www" = [ "<Super>b" ];
      "screensaver" = [ "<Shift><Super>L" ];
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      switch-to-application-5 = [ ];
      switch-to-application-6 = [ ];
      switch-to-application-7 = [ ];
      switch-to-application-8 = [ ];
      switch-to-application-9 = [ ];
    };

    "org/gnome/shell/keybindings/screenshot" = {
      take-screenshot = [ "<Super>s" ];
      shot-screenshot-ui = [ "<Shift><Super>s" ];
      toggle-quick-settings = [ ];
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = [
        "forge@jmmaranan.com"
        "blur-my-shell@aunetx"
        "mediacontrols@cliffniff.github.com"
      ];
    };

    "org/gnome/desktop/interface" = { cursor-size = 14; };

    "org/gnome/shell/extensions/forge" = { "focus-on-hover-enabled" = true; };

  };

  home.packages = with pkgs.gnomeExtensions; [
    forge
    blur-my-shell
    media-controls
  ];
}
