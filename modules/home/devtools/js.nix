{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bun
    typescript-language-server

    prettierd

    oxfmt
    oxlint

    tailwindcss-language-server
    astro-language-server
  ];
}
