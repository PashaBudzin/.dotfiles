# AGENTS.md - NixOS Dotfiles

## Quick Start

```bash
# Rebuild NixOS
sudo nixos-rebuild switch --flake .#lenovo

# Using nh helper
nh os switch        # switch to new config
nh boot             # reboot with updated config
```

## Structure

```
.dotfiles/
├── flake.nix              # Entry point, defines nixosConfigurations
├── settings.nix           # User & system settings
├── flake.lock             # Nix dependencies lock
├── AGENTS.md              # This file
├── hosts/
│   └── lenovo/
│       ├── default.nix            # NixOS + home-manager composition
│       ├── configuration.nix     # System config (boot, users, services)
│       ├── home.nix              # Home-manager modules import
│       └── hardware-configuration.nix
├── modules/
│   ├── home/                     # Home-manager modules (~/.config/nixpkgs)
│   │   ├── sh.nix                # Shell (zsh) config
│   │   ├── git.nix               # Git config
│   │   ├── neovim/nvim.nix       # Neovim IDE config
│   │   ├── hyprland/             # Hyprland window manager
│   │   ├── terminal/
│   │   │   ├── kitty.nix         # Kitty terminal
│   │   │   └── ghostty.nix       # Ghostty terminal (disabled)
│   │   ├── waybar.nix            # Waybar status bar
│   │   ├── dms/dms.nix          # DankMaterialShell
│   │   ├── tmux.nix             # Tmux config
│   │   ├── rofi.nix             # Rofi launcher
│   │   ├── gtk.nix              # GTK theming
│   │   ├── fonts.nix            # Font config
│   │   ├── cursor.nix           # Catppuccin cursor
│   │   ├── catppuccin.nix       # Catppuccin theme (disabled)
│   │   ├── vscode.nix           # VSCode config
│   │   ├── androidstudio.nix    # Android Studio config
│   │   ├── yazi.nix             # Yazi file manager
│   │   ├── apps.nix            # Applications
│   │   ├── hypr/               # Hyprland helper scripts
│   │   │   ├── bluelight.sh     # Blue light filter toggle
│   │   │   ├── bluelighttoggle.sh
│   │   │   ├── gamemode.sh     # Gaming mode toggle
│   │   │   └── keybinds.conf
│   │   └── devtools/            # Language devtools
│   │       ├── python.nix
│   │       ├── rust.nix
│   │       ├── go.nix
│   │       ├── js.nix
│   │       └── jdk.nix
│   └── system/                   # NixOS system modules
│       ├── autoupdate.nix         # Auto-update (viaagen)
│       ├── desktop.nix            # Desktop portals, XDG, flatpak
│       ├── gaming.nix           # Gaming (Steam, mangohud)
│       ├── hyprland.nix          # Hyprland system config
│       ├── kdeconnect.nix       # KDE Connect
│       ├── lsp/nixd.nix          # Nix language server
│       ├── network.nix           # Network config
│       ├── nh.nix               # nh helper
│       ├── virtualization.nix   # Virtualization (libvirt, waydroid)
│       ├── devtools.nix         # System devtools
│       └── programs.nix         # System programs
├── assets/
│   └── wallpapers/              # Wallpaper images
└── .git/modules/
    └── home/neovim/nvim/        # Neovim config submodule
```

## Architecture

- **NixOS flake** with home-manager
- **Host**: lenovo (x86_64-linux)
- **State**: `flakeDir` = `/home/pasha/.dotfiles`
- **Branch**: `nixos-unstable`
- **Shell**: zsh with starship prompt

## Configuration Flow

```
flake.nix
  ├── settings.nix (user/system settings)
  ├── hosts/lenovo/default.nix
  │   ├── configuration.nix (NixOS system)
  │   │   └── modules/system/*.nix
  │   └── home.nix (home-manager)
  │       └── modules/home/*.nix
```

## Key Modules

### Home (home-manager)

| Module | Purpose | Status |
|--------|---------|--------|
| `sh.nix` | Zsh shell + starship | Active |
| `hyprland/hyprland.nix` | Hyprland window manager | Active |
| `terminal/kitty.nix` | Kitty terminal | Active |
| `terminal/ghostty.nix` | Ghostty terminal | Disabled |
| `neovim/nvim.nix` | Neovim IDE | Active |
| `waybar.nix` | Waybar status bar | Active |
| `dms/dms.nix` | DankMaterialShell | Active |
| `tmux.nix` | Tmux multiplexer | Active |
| `rofi.nix` | Rofi launcher | Active |
| `cursor.nix` | Catppuccin cursor | Active |
| `catppuccin.nix` | Catppuccin theme | Disabled |
| `gtk.nix` | GTK theming | Active |
| `git.nix` | Git config | Active |
| `yazi.nix` | Yazi file manager | Active |
| `fonts.nix` | Font configuration | Active |
| `apps.nix` | Applications | Active |
| `vscode.nix` | VSCode | Active |

### System (NixOS)

| Module | Purpose | Status |
|--------|---------|--------|
| `desktop.nix` | XDG portals, flatpak | Active |
| `hyprland.nix` | Hyprland system | Active |
| `autoupdate.nix` | Auto-update | Active |
| `gaming.nix` | Gaming config | Active |
| `kdeconnect.nix` | KDE Connect | Active |
| `network.nix` | NetworkManager | Active |
| `nh.nix` | nh helper | Active |
| `virtualization.nix` | libvirt/waydroid | Disabled |
| `programs.nix` | System programs | Active |
| `devtools.nix` | Dev tools | Active |
| `lsp/nixd.nix` | Nix LSP | Active |

## Flake Inputs

| Input | Source | Purpose |
|-------|--------|---------|
| `nixpkgs` | `nixos-unstable` | NixOS packages |
| `home-manager` | nix-community | Home-manager |
| `hyprland` | git (with submodules) | Hyprland WM |
| `catppuccin` | catppuccin/nix | Catppuccin theming |
| `zen-browser` | zen-browser-flake | Zen Browser beta |
| `dms` | DankMaterialShell | DankMaterialShell |
| `dgop` | dgop | Dotfiles management |

## Known Disabled (by design)

- **Ghostty**: Module exists but not imported
- **Catppuccin**: Module exists but not imported
- **Virtualization**: libvirt/waydroid disabled

## Development

```bash
# Test configuration without applying
sudo nixos-rebuild dry-build --flake .#lenovo

# Check for errors
sudo nixos-rebuild build --flake .#lenovo

# Update flake lock
sudo nix flake update
```