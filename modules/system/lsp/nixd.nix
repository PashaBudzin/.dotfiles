{ lib, pkgs, config, inputs, ... }:

with lib;

{
  options.lsp.nix = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Enable the Nix development environment with LSP support
      (installs nixd, alejandra, nil, and sets nix.nixPath).
    '';
  };

  config = mkIf config.lsp.nix {
    environment.systemPackages = with pkgs; [ nixd alejandra nil ];

    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };
}
