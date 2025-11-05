{ config, pkgs, lib, ... }:

{
  options = {
    dev.androidStudio = lib.mkEnableOption "Whether to install Android Studio.";
  };

  config = lib.mkIf config.dev.androidStudio {
    home.packages = with pkgs; [ android-studio ];
  };
}
