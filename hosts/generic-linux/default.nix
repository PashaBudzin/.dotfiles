{
  config,
  pkgs,
  inputs,
  userSettings,
  systemSettings,
  ...
}:

{
  imports = [
    ../../modules/home/sh.nix
    ../../modules/home/git.nix
    ../../modules/home/tmux.nix
    ../../modules/home/terminal/kitty.nix

    ../../modules/home/opencode.nix

    ../../modules/scripts/tms.nix
    ../../modules/symlinks/hyprland.nix

    ../../modules/home/devtools/go.nix
    ../../modules/home/devtools/js.nix
    ../../modules/home/devtools/python.nix
    ../../modules/home/devtools/rust.nix
  ];

  home = {
    username = "pasha";
    homeDirectory = "/home/pasha";

    # Change this to the Home Manager release you're targeting.
    stateVersion = "25.05";
  };

  cli.enable = true;
  cli.direnv.enable = true;

  cli.zsh.enable = true;
  cli.zsh.useAntidote = true;
  cli.zsh.useOhMyZsh = false;

  cli.bash.enable = true;

  cli.starship.enable = true;

  dev.git = true;
  dev.tmux = true;

  terminals.kitty = {
    enable = false;
    config = {
      enable = true;
      dmsIntegration.enable = true;
    };
  };

  home.packages = with pkgs; [
    nh
  ];

  home.sessionVariables = {
    NH_FLAKE = userSettings.flakeDir;
  };

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "$HOME/.local/bin"
  ];
}
