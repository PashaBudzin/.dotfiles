{ lib, config, userSettings, ... }:

with lib;

{
  options.utils.nh = mkOption {
    type = types.bool;
    default = false;
    description = ''
      enable nh helper
    '';
  };

  config = mkIf config.utils.nh {
    programs.nh = {
      enable = true;
      flake = userSettings.flakeDir;
    };
  };
}
