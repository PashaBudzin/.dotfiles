{ pkgs, ... }: {
  imports = [ ./keybinds.nix ];

  xdg.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      source = ${../hypr/run.conf}
      source = $HOME/.run.conf

      ################
      ### MONITORS ###
      ################

      monitor=,preferred,auto,auto

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

              resize_on_border = false
              allow_tearing = false

              layout = dwindle
      }



          animations {
              enabled=1
                  bezier=overshot,0.13,0.99,0.29,1.1
                  animation=windows,1,4,overshot,slide
                  animation=fade,1,10,default
                  animation=workspaces,1,3,overshot,slidefadevert
                  animation=border,1,10,default
          }

      dwindle {
          pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
              preserve_split = true # You probably want this
      }

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

      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }

    '';
  };
}
