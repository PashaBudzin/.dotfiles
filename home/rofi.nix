{ pkgs, userSettings, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    plugins = with pkgs;
      [ (rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; }) ];

    extraConfig = {
      modi = "run,drun,calc";
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
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
    };

    theme = ./rofi/catppuccin-mocha.rasi;
  };
}
