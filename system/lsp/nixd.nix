{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [ nixd alejandra nil ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
