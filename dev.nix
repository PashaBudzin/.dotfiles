pkgs:
pkgs.mkShell {
  packages = with pkgs; [
    nodejs
    python3Minimal
    pnpm
    rust
    cargo
    rustc
    clippy
    go
    git
    tmux
    zsh
  ];

  shellHook = ''
    zsh
  '';
}
