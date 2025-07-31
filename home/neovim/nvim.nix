{ pkgs, config, lib, ... }:
let
  nvimDir = "${config.xdg.configHome}/nvim";
  nvimRepo = "https://github.com/PashaBudzin/nvim-config.git";
in {
  home.packages = with pkgs; [
    # neovim
    neovim

    fzf
    fd
    ripgrep

    # LSPS
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

    vscode-langservers-extracted
    graphql-language-service-cli

    git

    tree-sitter

    reflex
  ];

  home.activation.cloneNvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${pkgs.git}/bin:$PATH"
    if [ ! -d "${nvimDir}" ] || [ -z "$(ls -A "${nvimDir}")" ]; then
      echo "Cloning Neovim config from ${nvimRepo}..."
      git clone "${nvimRepo}" "${nvimDir}"
    else
      echo "Neovim config directory is not empty. Skipping clone."
    fi
  '';
}
