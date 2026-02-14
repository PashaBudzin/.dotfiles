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
    username = "pasha";
    name = "PashaBudzin";
    email = "pashabudzin@proton.me";
    flakeDir = "/home/pasha/.dotfiles";
    terminal = "kitty";
  };
}
