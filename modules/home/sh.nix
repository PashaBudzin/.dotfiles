{ config, pkgs, lib, ... }:

{
  options = {
    cli.enable = lib.mkEnableOption
      "Enable common CLI utilities (fzf, zoxide, btop, fastfetch, lazygit)";

    cli.direnv.enable =
      lib.mkEnableOption "Enable direnv with shell integrations";

    cli.shellAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        ls = "ls --color";
        l = "ls -la";
        vim = "nvim";
        vi = "nvim";
        c = "clear";
        md = "mkdir";
        cal = "cal -m";
        cd = "z";
        flinit = "nix flake init -t templates#utils-generic";
      };
      description = "Common shell aliases available in bash/zsh.";
    };

    cli.zsh.enable = lib.mkEnableOption "Enable Zsh with plugins and configs";
    cli.zsh.useAntidote = lib.mkEnableOption "Use Antidote plugin manager";
    cli.zsh.useOhMyZsh = lib.mkEnableOption "Use oh-my-zsh plugin manager";

    cli.bash.enable = lib.mkEnableOption "Enable Bash with aliases";

    cli.starship.enable =
      lib.mkEnableOption "Enable Starship prompt with integrations";
  };

  config = lib.mkMerge [

    # Core CLI tools
    (lib.mkIf config.cli.enable {
      programs.fzf.enable = true;
      programs.zoxide.enable = true;
      programs.btop.enable = true;
      programs.fastfetch.enable = true;
      programs.lazygit.enable = true;
      home.packages = with pkgs; [ gum dysk ];
    })

    # Direnv
    (lib.mkIf config.cli.direnv.enable {
      programs.direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
    })

    # Zsh
    (lib.mkIf config.cli.zsh.enable {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        shellAliases = config.cli.shellAliases;

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

          source $HOME/.secrets.sh
        '';

        antidote = lib.mkIf config.cli.zsh.useAntidote {
          enable = true;
          plugins = [
            "zsh-users/zsh-autosuggestions"
            "Aloxaf/fzf-tab"
            "chisui/zsh-nix-shell"
          ];
        };

        oh-my-zsh = lib.mkIf config.cli.zsh.useOhMyZsh {
          enable = true;
          plugins = [ "git" "aws" "sudo" "command-not-found" ];
        };
      };
    })

    # Bash
    (lib.mkIf config.cli.bash.enable {
      programs.bash = {
        enable = true;
        shellAliases = config.cli.shellAliases;
      };
    })

    # Starship
    (lib.mkIf config.cli.starship.enable {
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        settings.add_newline = false;
      };
    })
  ];
}
