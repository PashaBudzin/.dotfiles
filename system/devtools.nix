{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    volta
    go
    cargo
    rustc
    clippy
    python3
    insomnia
  ];

  programs.nix-ld.enable = true;
}
