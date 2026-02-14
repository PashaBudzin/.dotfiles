{ pkgs, ... }:
let theme = "catppuccin-mocha-mauve-standard";
in {
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";

      # package = pkgs.catppuccin-papirus-folders;
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = theme;

      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "mauve" "lavender" ];
      };
    };

    cursorTheme = {
      name = "catppuccin-mocha-lavender";

      package = pkgs.catppuccin-cursors.mochaLavender;
    };

    gtk3.extraConfig = {
      Settings = ''

        gtk-application-prefer-dark-theme=1

      '';
    };

    gtk4.extraConfig = {
      Settings = ''

        gtk-application-prefer-dark-theme=1

      '';
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "catppuccin-mocha-lavender";
    XCURSOR_SIZE = "24";
  };
}
