{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    volta
    go
    cargo
    rustc
    clippy
    python3
  ];

  programs.nix-ld.enable = true;
}
