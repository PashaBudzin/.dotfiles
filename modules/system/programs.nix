{ lib, pkgs, config, ... }:

with lib;

{
  options = {
    utils.common = mkOption {
      type = types.bool;
      default = false;
      description = "Install ffmpeg, imagemagick, jq, and neovim.";
    };
  };

  config = lib.mkIf config.utils.common {
    environment.systemPackages = with pkgs; [
      ffmpeg
      imagemagick
      jq
      neovim
      obs-studio
    ];
  };
}
