{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    volta
    bun
    go
    rustup
    clippy
    python3
    insomnia
    perl
    gnumake
  ];

  programs.nix-ld.enable = true;
}
