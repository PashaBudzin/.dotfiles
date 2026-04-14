{ pkgs, ... }:

{
  home.packages = with pkgs; [ ruff uv pyright jupyter-all ];

}
