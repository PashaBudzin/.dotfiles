{ lib, config, pkgs, ... }:

with lib;

{
  options = {
    utils.devtools = mkOption {
      type = types.bool;
      default = false;
      description = "Install common development tools and enable nix-ld.";
    };
  };

  config = {
    environment.systemPackages = mkIf config.utils.devtools [

      pkgs.insomnia

      pkgs.perl
      pkgs.gnumake

      pkgs.lsof

    ];

    programs.nix-ld.enable = config.utils.devtools;
  };
}
