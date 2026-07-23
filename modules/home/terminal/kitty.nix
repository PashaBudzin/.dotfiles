{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };

    settings = {
      shell_integration = "no-rc";
      enable_audio_bell = "no";
      hide_window_decorations = "yes";
      confirm_os_window_close = 0;
      font_size = 12;
      background_opacity = 1;
    };
  };

  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];
}
