{ lib, config, pkgs, ... }:

with lib;

{
  options = {
    gaming.enable = mkOption {
      type = types.bool;
      default = false;
      description =
        "Enable gaming-related programs and optimizations (graphics, Gamemode, Steam, etc).";
    };
  };

  config = {
    hardware.graphics.enable = config.gaming.enable;

    programs.gamemode.enable = config.gaming.enable;

    programs.steam.enable = config.gaming.enable;
    programs.steam.gamescopeSession.enable = config.gaming.enable;
  };
}
