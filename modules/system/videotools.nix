{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ ffmpeg imagemagick ];

  programs.obs-studio = {
    enable = true;

    enableVirtualCamera = true;
  };
}
