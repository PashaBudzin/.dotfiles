{ config, pkgs, lib, ... }:

{
  options.terminals.kitty =
    lib.mkEnableOption "Enable Kitty terminal emulator.";

  config = lib.mkIf config.terminals.kitty {
    programs.kitty = {
      enable = true;
      settings = {
        shell_integration = "no-rc";
        enable_audio_bell = "no";
        hide_window_decorations = "yes";
        confirm_os_window_close = 0;
        font_size = 12;
        background_opacity = 0.8;
      };
      font = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
    };
  };
}
