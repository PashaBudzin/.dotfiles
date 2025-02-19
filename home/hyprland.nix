{pkgs, ...}: {
  xdg.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''

      # This is an example Hyprland config file.
      # Refer to the wiki for more information.
      # https://wiki.hyprland.org/Configuring/Configuring-Hyprland/

      # Please note not all available settings / options are set here.
      # For a full list, see the wiki

      # You can split this configuration into multiple files
      # Create your files separately and then link them to this file like this:
      source = ${./hypr/keybinds.conf}
      source = ${./hypr/run.conf}
      source = ${./hypr/rules.conf}
      source = ${./hypr/mocha.conf}

      ################
      ### MONITORS ###
      ################

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=,preferred,auto,auto

      # unscale XWayland
      xwayland {
          force_zero_scaling = true
      }

      # See https://wiki.hyprland.org/Configuring/Keywords/
      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      # Or execute your favorite apps at launch like this:



      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################

      # See https://wiki.hyprland.org/Configuring/Environment-variables/

      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_WAYLAND_DISABLED_INTERFACES,wp_fractional_scale_manager_v1

      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_SESSION_DESKTOP,Hyprland

      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1

      env = GTK_USE_PORTAL,1

      #####################
      ### LOOK AND FEEL ###
      #####################

      # Refer to https://wiki.hyprland.org/Configuring/Variables/

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general {
          gaps_in = 2
              gaps_out = 5

              border_size = 1

      # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
              col.active_border=$lavender $mauve 45deg
              col.inactive_border=$base

      # Set to true enable resizing windows by clicking and dragging on borders and gaps
              resize_on_border = false

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
              allow_tearing = false

              layout = dwindle
      }


      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration {
          rounding=10
              blur {
                  enabled=1
                      size=5 # minimum 1
                      passes=4 # minimum 1, more passes = more resource intensive.
                      new_optimizations = true
                      ignore_opacity = true
                      xray=1
              }
      }

      # https://wiki.hyprland.org/Configuring/Variables/#animations
          animations {
              enabled=1
      # bezier=overshot,0.05,0.9,0.1,1.1
                  bezier=overshot,0.13,0.99,0.29,1.1
                  animation=windows,1,4,overshot,slide
                  animation=fade,1,10,default
                  animation=workspaces,1,3,overshot,slidefadevert
                  animation=border,1,10,default
          }

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle {
          pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
              preserve_split = true # You probably want this
      }

      # # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      # master {
      #     new_is_master = true
      # }

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc {
          force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
      }


      #############
      ### INPUT ###
      #############

      # https://wiki.hyprland.org/Configuring/Variables/#input
      input {
          kb_layout = us,ua
          kb_variant =
          kb_model =
          kb_options = grp:win_space_toggle
          kb_rules =

          follow_mouse = 1

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

          touchpad {
              natural_scroll = true
          }
      }

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures {
          workspace_swipe = false
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }


      ####################
      ### KEYBINDINGSS ###
      ####################

      # See https://wiki.hyprland.org/Configuring/Keywords/

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

      # Example windowrule v1
      # windowrule = float, ^(kitty)$

      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

      windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
    '';
  };

  xdg.configFile."hypr/keybinds.conf".source = ./hypr/keybinds.conf;
  xdg.configFile."hypr/run.conf".source = ./hypr/run.conf;

  xdg.configFile."hypr/mocha.conf".source = ./hypr/mocha.conf;
  xdg.configFile."hypr/rules.conf".source = ./hypr/rules.conf;
  xdg.configFile."hypr/gamemode.sh".source = ./hypr/gamemode.sh;
  xdg.configFile."hypr/hypridle.conf".source = ./hypr/hypridle.conf;

  xdg.configFile."hypr/bluelight.sh".source = ./hypr/bluelight.sh;
  xdg.configFile."hypr/bluelighttoggle.sh".source = ./hypr/bluelighttoggle.sh;

  programs.wlogout = {
    enable = true;
  };

  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = toString ../wallpapers/nix-magenta-pink-1920x1080.png;
    wallpaper = ", " + toString ../wallpapers/nix-magenta-pink-1920x1080.png;
  };

  home.packages = with pkgs; [
    hyprsunset
    brightnessctl
    hyprpicker
    blueman
    pavucontrol
    playerctl
    grim
    slurp
    wl-clipboard
  ];
}
