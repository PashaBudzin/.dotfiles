{ config, pkgs, lib, ... }:

{
  options = {
    dev.nvim.enable =
      lib.mkEnableOption "Enable Neovim with plugins, tools, and config repo.";

    dev.nvim.cloneConfig = lib.mkEnableOption
      "Automatically clone a Neovim config repo on activation.";

    dev.nvim.repo = lib.mkOption {
      type = lib.types.str;
      default = "https://github.com/PashaBudzin/nvim-config.git";
      description = "Git repository to clone as Neovim config.";
    };

    dev.nvim.extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Extra packages to install with Neovim setup.";
    };
  };

  config = lib.mkIf config.dev.nvim.enable {
    home.packages = with pkgs;
      [
        neovim
        fzf
        fd
        ripgrep

        # Language servers & formatters
        lua-language-server

        typescript-language-server
        vscode-langservers-extracted
        yaml-language-server
        pyright

        codespell

        stylua
        prettierd
        gcc
        gopls
        clang-tools

        nixfmt-classic
        tailwindcss-language-server
        astro-language-server
        graphql-language-service-cli

        # java/kotlin 
        kotlin-language-server
        ktfmt
        google-java-format
        jdt-language-server

        git
        nodejs_22
        tree-sitter
        reflex
        cmake
      ] ++ config.dev.nvim.extraPackages;

    home.activation.cloneNvimConfig = lib.mkIf config.dev.nvim.cloneConfig
      (lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        export PATH="${pkgs.git}/bin:$PATH"
        nvimDir="${config.xdg.configHome}/nvim"
        if [ ! -d "$nvimDir" ] || [ -z "$(ls -A "$nvimDir")" ]; then
          echo "Cloning Neovim config from ${config.dev.nvim.repo}..."
          git clone "${config.dev.nvim.repo}" "$nvimDir"
        else
          echo "Neovim config directory is not empty. Skipping clone."
        fi
      '');
  };
}
