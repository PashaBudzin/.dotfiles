{ pkgs, inputs, ... }:

{
  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    dgop.package = inputs.dgop.packages.${pkgs.system}.default;
  };

  wayland.windowManager.hyprland.extraConfig = ''
    source = $HOME/.config/hypr/dms/colors.conf
    source = $HOME/.config/hypr/dms/layout.conf
  '';

  programs.kitty = {
    extraConfig = ''
      include ~/.config/kitty/dank-theme.conf
      include ~/.config/kitty/dank-tabs.conf
    '';
  };

  home.packages = with pkgs; [ adw-gtk3 papirus-icon-theme ];
}
