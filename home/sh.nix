{ config, pkgs, ... }:
let
  shellAliases = {
    ls = "ls --color";
    l = "ls -la";
    vim = "nvim";
    vi = "nvim";
    c = "clear";
    md = "mkdir";
    cal = "cal -m";
    cd = "z";
    dev = "nix develop ~/.dotfiles";
  };
in {
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.btop.enable = true;

  programs.fastfetch = { enable = true; };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    inherit shellAliases;

    antidote = {
      enable = true;
      plugins = [''
        zsh-users/zsh-autosuggestions
        Aloxaf/fzf-tab
        chisui/zsh-nix-shell
      ''];
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "aws" "sudo" "command-not-found" ];
    };

    initContent = ''
      bindkey -v
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^[w' kill-region

      HISTSIZE=5000
      HISTFILE=~/.zsh_history
      SAVEHIST=$HISTSIZE
      HISTDUP=erase
      setopt appendhistory
      setopt sharehistory
      setopt hist_ignore_space
      setopt hist_ignore_all_dups
      setopt hist_save_no_dups
      setopt hist_ignore_dups
      setopt hist_find_no_dups

      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"

      export PATH=$PATH:$HOME/.volta/bin
    '';
  };

  programs.bash = {
    enable = true;

    inherit shellAliases;
  };

  programs.starship = {
    enableZshIntegration = true;
    enableBashIntegration = true;

    enable = true;

    settings = { add_newline = false; };
  };

  home.packages = with pkgs; [ gum ];
}
