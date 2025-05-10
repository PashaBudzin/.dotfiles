{ ... }: {
  programs.hyprlock = { enable = true; };

  services.hypridle.enable = true;

  xdg.configFile."hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
  xdg.configFile."hypr/hypridle.conf".source = ./hypr/hypridle.conf;
}
