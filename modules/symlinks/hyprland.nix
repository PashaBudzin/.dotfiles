{ config, userSettings, ... }:

let
  hyprDir = "${userSettings.flakeDir}/modules/symlinks/hypr";
in
{
  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink hyprDir;
}
