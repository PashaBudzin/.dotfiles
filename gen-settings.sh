#!/usr/bin/env bash

set -e

clear

echo "Generating NixOS Config..."

# -------- SYSTEM SETTINGS --------
echo "Enter hostname:"
hostname=$(gum input --placeholder "Hostname" --value "nixos")

echo "Select timezone:"
timezone=$(timedatectl list-timezones | gum filter --placeholder "Search timezone...")

echo "Enter locale:"
locale=$(gum input --placeholder "Locale" --value "uk_UA.UTF-8")

echo "Enable virtualization?"
enable_virt=$(gum choose "true" "false")

# -------- USER SETTINGS --------
echo "Enter username:"
username=$(gum input --placeholder "Username" --value "pasha")

echo "Enter full name:"
name=$(gum input --placeholder "Full name" --value "Pasha")

echo "Enter email:"
email=$(gum input --placeholder "Email" --value "pashabudzin@proton.me")

echo "Enter dotfiles directory:"
dotfiles=$(gum input --placeholder "Dotfiles directory" --value "~/.dotfiles")

# -------- Generate config function --------
generate_config() {
cat <<EOF
{ pkgs, ... }:
{
  systemSettings = {
    # ------- SYSTEM SETTINGS ---------
    hostname = "${hostname}";
    profile = "personal";
    timezone = "${timezone}";
    locale = "${locale}";
    enableVirtualization = ${enable_virt};
  };
  userSettings = {
    # ------- USER SETTINGS ---------
    username = "${username}";
    name = "${name}";
    email = "${email}";
    dotfilesDir = "${dotfiles}";
    terminal = "kitty";
    fontPkg = pkgs.maple-mono-NF;
    font = "Maple Mono NF";
  };
}
EOF
}

# -------- Confirmation Loop --------
final_config="$(generate_config)"

while true; do
  clear
  gum style \
    --border normal \
    --width 80 \
    --padding "1 2" \
    --margin "1 0" \
    --align left \
    "$final_config"

  choice=$(gum choose --header "Is everything correct?" "Yes" "Manually edit" "Abort")

  case "$choice" in
    "Yes")
      echo "✅ Config accepted."
      printf "%s\n" "$final_config" > settings.nix
      break
      ;;
    "Manually edit")
      tmpfile=$(mktemp /tmp/nixos-config-XXXX.nix)
      echo "$final_config" > "$tmpfile"
      nano "$tmpfile"
      final_config=$(cat "$tmpfile")
      rm "$tmpfile"
      ;;
    "Abort")
      echo "❌ Aborted."
      exit 1
      ;;
  esac
done

