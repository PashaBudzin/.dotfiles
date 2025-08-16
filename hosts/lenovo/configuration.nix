{ pkgs, userSettings, systemSettings, lib, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/system/desktop.nix
    ../../modules/system/hyprland.nix
    ../../modules/system/autoupdate.nix
    ../../modules/system/gaming.nix
    ../../modules/system/kdeconnect.nix
    ../../modules/system/devtools.nix
    ../../modules/system/programs.nix
    ../../modules/system/lsp/nixd.nix
    ../../modules/system/virtualization.nix
    ../../modules/system/nh.nix
    ../../modules/system/network.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lenovo";

  networking.networkmanager.enable = true;

  time.timeZone = lib.mkForce null;

  services.geoclue2.enable = true;
  services.tzupdate.enable = true;
  services.timesyncd.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "${userSettings.username}";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.flatpak.enable = true;

  system.autoupdate = true;

  desktop.xserver = true;
  desktop.gnome = true;
  desktop.gdm = true;
  desktop.gtkPortals = true;
  desktop.waylandEnvironmentVariables = true;

  desktop.hyprland = true;
  hyprland.portals = true;

  utils.nh = true;
  utils.common = true;
  utils.devtools = true;

  virtualization.qemu = true;
  virtualization.waydroid = true;

  networking.zerotier = true;
  networking.openCommonPorts = true;

  apps.kdeconnect = true;

  gaming.enable = true;

  lsp.nix = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
