{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    youtube-music
    materialgram
    mangohud
    libresprite
    tdf
  ];

  programs.zen-browser.enable = true;
}
