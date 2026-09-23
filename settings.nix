{ pkgs, ... }: {
  systemSettings = {
    # ------- SYSTEM SETTINGS ---------
    profile = "personal";
    timezone = "Europe/Kyiv";
    locale = "uk_UA.UTF-8";
    enableVirtualization = true;
    system = "x86_64-linux";
  };
  userSettings = {
    # ------- USER SETTINGS ---------
    username = "natalabudzina";
    name = "PashaBudzin";
    email = "pashabudzin@proton.me";
    flakeDir = "/Users/natalabudzina/.dotfiles";
    terminal = "kitty";
  };
}
