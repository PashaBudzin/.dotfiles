{ pkgs, config, ... }: {
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./.;
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

    tree-sitter
  ];
}
