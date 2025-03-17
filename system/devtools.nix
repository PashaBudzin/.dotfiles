{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    volta
    bun
    go
    cargo
    rustc
    clippy
    python3
    insomnia
  ];

  programs.nix-ld.enable = true;
}
