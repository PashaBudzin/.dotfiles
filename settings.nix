{ pkgs, ... }:
{
    systemSettings = {
      # ------- SYSTEM SETTINGS ---------
      hostname = "nixos";
      profile = "personal";
      timezone = "Europe/Kyiv";
      locale = "uk_UA.UTF-8";
      enableVirtualization = true;
    };
    userSettings = {
      # ------- USER SETTINGS ---------
      username = "pasha";
      name = "Pasha";
      email = "pashabudzin@proton.me";
      dotfilesDir = "~/.dotfiles";
      terminal = "kitty";
      fontPkg = pkgs.maple-mono-NF;
      font = "Maple Mono NF";
    };
}
