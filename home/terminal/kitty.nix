{ userSettings, ... }: {
  programs.kitty = {
    enable = true;

    settings = {
      shell_integration = "no-rc";
      enable_audio_bell = "no";
      hide_window_decorations = "yes";

      confirm_os_window_close = 0;
      font_size = 12;
    };

    font.package = userSettings.fontPkg;
    font.name = userSettings.font;
  };
}
