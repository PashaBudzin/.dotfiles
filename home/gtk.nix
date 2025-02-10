{pkgs, ...}: let
  theme = "catppuccin-mocha-mauve-standard";
in {
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";

      package = pkgs.catppuccin-papirus-folders;
    };

    theme = {
      name = theme;

      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = ["mauve" "lavender"];
      };
    };

    cursorTheme = {
      name = "catppuccin-mocha-lavender";

      package = pkgs.catppuccin-cursors;
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

  home.sessionVariables.GTK_THEME = theme;
}
