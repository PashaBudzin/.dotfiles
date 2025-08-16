{ lib, config, pkgs, ... }:

with lib;

{
  options = {
    apps.kdeconnect = mkOption {
      type = types.bool;
      default = false;
      description = "Enable KDE Connect application.";
    };
  };

  config = { programs.kdeconnect.enable = mkIf config.apps.kdeconnect true; };
}
