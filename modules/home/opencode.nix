{ pkgs, ... }: { 
    programs.opencode = { enable = true; };
    home.packages = with pkgs; [
        codex
    ];
}
