{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = {
            name = "kvantum";
            package = pkgs.libsForQt5.qtstyleplugin-kvantum;
        };

  };


    home.sessionVariables = {
        QT_STYLE_OVERRIDE = "kvantum";
    };

}
