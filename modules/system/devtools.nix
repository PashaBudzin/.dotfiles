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
      pkgs.bun
      pkgs.go
      pkgs.rustup
      pkgs.clippy
      pkgs.python3
      pkgs.python3Packages.matplotlib
      pkgs.insomnia
      pkgs.perl
      pkgs.gnumake

      pkgs.opencode
    ];

    programs.nix-ld.enable = config.utils.devtools;
  };
}
