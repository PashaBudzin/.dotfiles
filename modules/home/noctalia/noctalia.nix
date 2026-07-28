{ config, inputs, pkgs, ... }:

{
  home.packages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.adw-gtk3
    pkgs.qt6Packages.qt6ct
  ];

  home.sessionVariables.QT_QPA_PLATFORMTHEME = "qt6ct";

  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.xdg.configHome}/qt6ct/colors/noctalia.conf
    custom_palette=true
  '';

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
