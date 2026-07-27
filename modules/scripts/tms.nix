{ pkgs, ... }:

let
  tms = pkgs.writeShellScriptBin "tms" ''
    export PATH=${
      pkgs.lib.makeBinPath [ pkgs.fzf pkgs.findutils pkgs.coreutils pkgs.tmux pkgs.git ]
    }:$PATH

    : "''${TMS_DIRS:=$HOME/proj $HOME/s $HOME/.dotfiles $HOME/.config/nvim}"

    tms() {
        selected=$(
            printf "%s\n" $TMS_DIRS \
            | while IFS= read -r dir; do
                find "$dir" -mindepth 0 -maxdepth 1 -type d \
                    -exec test -d "{}/.git" \; -print 2>/dev/null
              done \
            | while IFS= read -r repo; do
                printf "%s\n" "$repo"
                git -C "$repo" worktree list 2>/dev/null \
                  | awk -v repo="$repo" "
                      NR > 1 {
                        path = \$1
                        tag = \$NF
                        gsub(/^\\[|\\]\$/, \"\", tag)
                        gsub(/^\\(|\\)\$/, \"\", tag)
                        if (path != repo) print path \"|\" tag
                      }
                    "
              done \
            | fzf --delimiter='\|' --with-nth=1,2 \
                  --preview='
                    echo " {1}"
                    echo " ─────────────────────────────"
                    git -C {1} log --oneline --color=always -10 2>/dev/null
                  ' \
                  --preview-window='right:60%'
        )

        [ -z "$selected" ] && exit 0
        selected="''${selected%%|*}"

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
