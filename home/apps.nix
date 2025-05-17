{ pkgs, ... }: {
  home.packages = with pkgs; [
    youtube-music
    materialgram
    mangohud
    libresprite
  ];

}
