{ pkgs, ... }: {
  home.packages = with pkgs; [ maple-mono.NF ];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "right";

        modules-left = [ "clock" "pulseaudio" "battery" "network" "bluetooth" ];
        modules-center = [ "mpris" ];
        modules-right = [ "memory" "power-profiles-daemon" ];

        "memory" = {
          "interval" = 30;
          "format" = "{}% ";
          "rotate" = 90;
        };

        "power-profiles-daemon" = {
          "rotate" = 90;
          "format" = "{icon}";
          "tooltip-format" = ''
            Power profile: {profile}
            Driver: {driver}'';
          "tooltip" = true;
          "format-icons" = {
            "default" = "";
            "performance" = "";
            "balanced" = "";
            "power-saver" = "";
          };
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
          format-icons = {
            "active" = "";
            "urgent" = "";
            "default" = "";
          };
        };

        mpris = {
          format = "{status_icon} {dynamic}";

          rotate = 90;

          interval = 1;
          dynamic-len = 40;
          status-icons = {
            "playing" = "▶";
            "paused" = "⏸";
            "stopped" = "";
          };

          dynamic-order = [ "title" "artist" ];
          ignored-players = [ "firefox" "zen" ];
        };

        clock = {
          format = ''
            {:%H
            %M}'';
          tooltip = false;
        };

        pulseaudio = {
          format = "{volume}% ";
          rotate = 90;
          scroll-step = 1;
        };

        battery = {
          format = "{capacity}% {icon}";
          rotate = 90;
          format-icons = [ "" "" "" "" "" ];
        };

        network = {
          format-wifi = " ";
          format-ethernet = "󰈀";
          format-disconnected = "⚠";
          tooltip = true;
        };
        bluetooth = {
          "format-on" = "󰂯";
          "format-off" = "O󰂲";
          "format-disabled" = "󰂲";
          "format-connected-battery" = "󰂯";
          "format-alt" = "{device_alias} 󰂯";
          "tooltip-format" = ''
            {controller_alias}	{controller_address}

            {num_connections} connected'';
          "tooltip-format-connected" = ''
            {controller_alias}	{controller_address}

            {num_connections} connected

            {device_enumerate}'';
          "tooltip-format-enumerate-connected" = ''
            {device_alias}
            {device_address}'';
          "tooltip-format-enumerate-connected-battery" = ''
            {device_alias}
            {device_address}
            {device_battery_percentage}%'';
          "on-click-right" = "blueman-manager";
        };
      };
    };

    style = ''
      #clock, #pulseaudio, #battery, #network, #power-profiles-daemon {
        padding: 8px;
      }

      window#waybar {
        background: rgba(0, 0, 0, 0);
        color: @blue;
        font-size: 14px;
      }

      .modules-left {
        background: @base;

        border-radius: 30px;
        margin-top: 10px;
        padding: 0px;
      }

      .modules-right {
        background: @base;

        border-radius: 30px;
        margin-bottom: 10px;
        padding: 10px 4px;
      }

      .modules-center {
        background: @base;

        border-radius: 30px;

        padding: 0px 4px;
      }
    '';
  };
}
