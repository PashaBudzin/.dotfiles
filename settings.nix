{ pkgs, ... }: {
  systemSettings = {
    # ------- SYSTEM SETTINGS ---------
    hostname = "nixos";
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
    dotfilesDir = "/home/pasha/.dotfiles";
    terminal = "kitty";
    fontPkg = pkgs.maple-mono.NF;
    font = "Maple Mono NF";
  };
}
