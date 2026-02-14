{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    bind = [

      "$mainMod, Q, exec, kitty"

      "$mainMod SHIFT, D, exec, [workspace 1 silent fullscreen] kitty -o window_padding_width=0 -o confirm_os_window_close=1 -e 'tms'"

      "$mainMod, C, killactive,"
      "$mainMod, E, exec, nautilus"
      "$mainMod, V, togglefloating,"
      "$mainMod, R, exec, rofi -show drun"
      "$mainMod SHIFT, E, exec, rofi -show emoji"

      "$mainMod, D, pseudo, # dwindle"
      "$mainMod, X, togglesplit, # dwindle"

      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"

      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      ''$mainMod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy''
      "$mainMod, S, exec, grim - | wl-copy"

      "bind  = $mainMod SHIFT, W, exec, hyprpicker | wl-copy"

      "bind  = $mainMod SHIFT, L, exec, wlogout"

      "$mainMod, F, fullscreen"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

      ",XF86MonBrightnessDown,exec, brightnessctl set 10%-"
      ",XF86MonBrightnessUp,exec, brightnessctl set 10%+"

      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

      "$mainMod, I, exec, playerctl play-pause"
      "$mainMod, O, exec, playerctl next"

      ",XF86AudioPlay, exec, playerctl play-pause"
      ",XF86AudioNext, exec, playerctl next"
      ",XF86AudioPrev, exec, playerctl previous"

      "$mainMod, A, exec, makoctl dismiss"
      "$mainMod SHIFT, A, exec, makoctl dismiss -a"
      "$mainMod SHIFT, P, exec, makoctl mode -t do-not-disturb"

      "$mainMod SHIFT, G, exec, ~/.config/hypr/bluelighttoggle.sh"

      # gamemode

      "$mainMod, G, exec, ~/.config/hypr/gamemode.sh"

      "SUPER SHIFT, F, exec, hyprshade toggle blue-light-filter"

    ];

    binde = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
    ];

    bindm = [
      "bindm = $mainMod, mouse:272, movewindow"
      "bindm = $mainMod, mouse:273, resizewindow"
    ];
  };

  home.packages = with pkgs; [
    brightnessctl
    hyprpicker
    blueman
    pavucontrol
    playerctl
    grim
    slurp
  ];
}
