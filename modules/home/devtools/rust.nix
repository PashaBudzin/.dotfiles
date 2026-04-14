{ pkgs }: { home.packages = with pkgs; [ pkgs.rustup pkgs.clippy ]; }
