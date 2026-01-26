{ pkgs, userSettings, inputs, ... }: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.zen-browser.homeModules.beta

    ../../modules/home/sh.nix
    ../../modules/home/neovim/nvim.nix
    ../../modules/home/terminal/kitty.nix
    ../../modules/home/gtk.nix
    ../../modules/home/gnome.nix
    ../../modules/home/apps.nix
    ../../modules/home/waybar.nix
    ../../modules/home/rofi.nix
    ../../modules/home/catppuccin.nix
    ../../modules/home/tmux.nix
    ../../modules/home/cursor.nix
    ../../modules/home/git.nix
    ../../modules/home/yazi.nix
    ../../modules/home/qt.nix

    # ../../modules/home/androidstudio.nix

    ../../modules/home/hyprland.nix
    ../../modules/home/hyprlock.nix

    ../../modules/scripts/scripts.nix
  ];

  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
  };

  desktops.gnome = true;
  dev.git = true;

  cli.enable = true;
  cli.direnv.enable = true;

  cli.zsh.enable = true;
  cli.zsh.useAntidote = true;
  cli.zsh.useOhMyZsh = false;

  cli.bash.enable = true;

  cli.starship.enable = true;

  dev.nvim.enable = true;
  dev.nvim.cloneConfig = true;

  # dev.androidStudio = true;

  dev.tmux = true;

  utils.yazi = true;

  terminals.kitty = true;

  apps = {
    zen.enable = true;
    zen.setDefault = true;

    pear-desktop = true;
    materialgram = true;
    mangohud = true;
    libresprite = true;
    pied = true;
    tdf = true;
    readest = false;
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [ rclone ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
