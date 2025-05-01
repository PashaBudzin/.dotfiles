#!/usr/bin/env bash

gum style --border double --padding "1 2" --border-foreground 10 "Fetching flake from github"

git clone "https://github.com/PashaBudzin/.dotfiles" "dest"
cd dest
chmod +x installer.sh

./gen-settings.sh
