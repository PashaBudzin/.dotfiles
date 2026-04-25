{ pkgs, ... }:

let
  tms = pkgs.writeShellScriptBin "tms" ''
    export PATH=${
      pkgs.lib.makeBinPath [ pkgs.fzf pkgs.findutils pkgs.coreutils pkgs.tmux ]
    }:$PATH

    : "''${TMS_DIRS:=$HOME/proj $HOME/s $HOME/.dotfiles $HOME/.config/nvim}"

    tms() {
        selected=$(
            printf "%s\n" $TMS_DIRS \
            | while IFS= read -r dir; do
                find "$dir" -mindepth 0 -maxdepth 1 -type d \
                    -exec test -d "{}/.git" \; -print 2>/dev/null
              done \
            | fzf
        )

        [ -z "$selected" ] && exit 0

        selected_name=$(basename "$selected" | tr . _)

        if ! tmux has-session -t "$selected_name" 2>/dev/null; then
            tmux new-session -ds "$selected_name" -c "$selected"
        fi

        if [ -n "$TMUX" ]; then
            tmux switch-client -t "$selected_name"
        else
            tmux attach-session -t "$selected_name"
        fi
    }

    switch() {
        selected_name=$(tmux list-sessions -F '#S' 2>/dev/null | fzf)

        [ -z "$selected_name" ] && exit 0

        if [ -n "$TMUX" ]; then
            tmux switch-client -t "$selected_name"
        else
            tmux attach-session -t "$selected_name"
        fi
    }

    case "$1" in
        switch)
            switch
            ;;
        *)
            tms
            ;;
    esac
  '';
in { home.packages = [ tms ]; }
