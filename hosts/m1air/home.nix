{ pkgs, ... }:

{
  home.stateVersion = "24.05";

  imports = [
        ../../modules/home/terminal/ghostty.nix
        ../../modules/home/sh.nix
        ../../modules/home/git.nix
        ../../modules/home/tmux.nix
        ../../modules/home/devtools/js.nix
        ../../modules/home/opencode.nix
        # ../../modules/home/yabai/yabai.nix

        ../../modules/scripts/tms.nix
    ];

  cli.enable = true;
  cli.direnv.enable = true;

  cli.zsh.enable = true;
  cli.zsh.useAntidote = true;
  cli.zsh.useOhMyZsh = false;

  cli.bash.enable = true;

  cli.starship.enable = true;

  dev.git = true;
  dev.tmux = true;

  home.packages = with pkgs; [
    neovim
  ];
}
