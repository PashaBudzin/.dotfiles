{ pkgs, ... }:
{
    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.catppuccin-cursors.mochaLavender;
        name = "catppuccin-mocha-lavender";
        size = 16;
    };

    home.file.".icons/default".source =
      "${pkgs.catppuccin-cursors.mochaLavender}/share/icons/catppuccin-mocha-lavender-cursors";
}
