{ lib, config, inputs, ... }:

with lib;

{
  options = {
    system.autoupdate = mkOption {
      type = types.bool;
      default = false;
      description = "Enable automatic system upgrades and garbage collection.";
    };
  };

  config = mkIf config.system.autoupdate {
    system.autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "-L" # print build logs
      ];
      dates = "12:00";
      randomizedDelaySec = "45min";
    };

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
