{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    volta
    bun
    go
    rustup
    clippy
    python3
    python3Packages.matplotlib
    insomnia
    perl
    gnumake
  ];

  programs.nix-ld.enable = true;
}
