{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    keymap = {
      manager.prepend_keymap = [{
        run = [

          ''
            shell -- for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list''
          "yank"
        ];
        on = [ "y" ];
      }];
    };
  };

  home.packages = with pkgs; [ wl-clipboard ];
}
