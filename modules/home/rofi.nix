{ pkgs, userSettings, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    plugins = with pkgs; [
      (rofi-calc.override { rofi-unwrapped = rofi; })
      rofi-emoji
    ];

    extraConfig = {
      modi = "emoji,drun,calc";
      icon-theme = "Oranchelo";
      show-icons = true;
      terminal = userSettings.terminal;
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 󰕰  Window";
      display-calc = " Calculator";
      display-emoji = "󰞅 Emoji";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
    };

    theme = ./rofi/catppuccin-mocha.rasi;
  };
}
