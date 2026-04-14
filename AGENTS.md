# AGENTS.md - NixOS Dotfiles

## Quick Start

```bash
# Rebuild NixOS
sudo nixos-rebuild switch --flake .#lenovo

# Using nh helper (installed via nh module)
nh os switch        # switch to new config
nh boot             # reboot with updated config
```

## Structure

- `flake.nix` - entry point, defines nixosConfigurations
- `hosts/lenovo/` - machine-specific NixOS config
- `modules/` - reusable modules (home/, system/)
- `settings.nix` - user/system settings (username, email, etc.)

## Architecture

- NixOS flake with home-manager
- Host: lenovo (x86_64-linux)
- State: `flakeDir` = `/home/pasha/.dotfiles`

## Key Modules

- `modules/home/hyprland/` - Hyprland window manager
- `modules/home/terminal/kitty.nix` - Kitty terminal
- `modules/home/terminal/ghostty.nix` - Ghostty terminal
- `modules/home/neovim/nvim.nix` - Neovim config
- `modules/home/waybar.nix` - Waybar
- `modules/home/dms/dms.nix` - DankMaterialShell

## Notes

- Uses `nixos-unstable` branch
- Hyprland built from git with submodules
- Catppuccin theming
