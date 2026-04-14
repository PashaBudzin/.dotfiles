{ pkgs, ... }: {
  home.packages = with pkgs; [
    bun
    typescript-language-server

    prettierd

    tailwindcss-language-server
    astro-language-server
  ];
}
