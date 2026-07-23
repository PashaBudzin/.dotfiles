{ inputs, pkgs, ... }:

{
  home.packages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.adw-gtk3
  ];

  programs.kitty = {
    extraConfig = ''
      include ~/.config/kitty/themes/noctalia.conf
    '';
  };

  dconf = {
    enable = true;

    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "adw-gtk3";
        color-scheme = "prefer-dark";
      };
    };
  };
}
