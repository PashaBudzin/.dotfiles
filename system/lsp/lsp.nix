{pkgs, ...}: {
  imports = [
    ./nixd.nix
  ];

  environment.systemPackages = with pkgs; [
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
    nixfmt
  ];
}
