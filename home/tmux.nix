{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    shell = "${pkgs.zsh}/bin/zsh";

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      tmuxPlugins.catppuccin
    ];

    extraConfig = ''
      unbind r
      bind r source-file ~/.tmux.conf
      set -g prefix C-s

      # Set new panes to open in current directory
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind-key -n C-l send-keys "C-l" "clear" Enter

      set -g mouse on
      set -g base-index 1
      set -g pane-base-index 1
      set-option -g renumber-windows on
      setw -g mode-keys vi
      set -s set-clipboard on

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      set -g @plugin 'christoomey/vim-tmux-navigator'
      set -g @plugin 'tmux-plugins/tmux-yank'

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mpde-vi y send-keys -X copy-selection-and-cancel
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g @plugin 'catppuccin/tmux'
      set -g @catppuccin_flavour 'mocha'
      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator ""
      set -g @catppuccin_window_middle_separator " █"
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W"
      set -g @catppuccin_status_modules_right "directory user session date_time"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator ""
      set -g @catppuccin_status_right_separator_inverse "no"
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"
      set -g @catppuccin_date_time_text "%H:%M"
      set -g status-position top
      set -g @catppuccin_directory_text "#{pane_current_path}"

    '';
  };
}
