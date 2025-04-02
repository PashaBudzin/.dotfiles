{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    catppuccin.url = "github:catppuccin/nix";

    ags.url = "github:aylur/ags";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprpanel.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    catppuccin,
    ags,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        inputs.hyprpanel.overlay
      ];
    };
    systemSettings = {
      # ------- SYSTEM SETTINGS ---------
      hostname = "nixos";
      profile = "personal";
      timezone = "Europe/Kyiv";
      locale = "uk_UA.UTF-8";
      enableTailscale = true;
    };
    userSettings = {
      # ------- USER SETTINGS ---------
      username = "pasha";
      name = "Pasha";
      email = "pashabudzin@proton.me";
      dotfilesDir = "~/.dotfiles";
      terminal = "kitty";
      fontPkg = pkgs.maple-mono-NF;
      font = "Maple Mono NF";
    };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
        inherit system;
        modules = [
          ./configuration.nix
          catppuccin.nixosModules.catppuccin
        ];
      };
    };
    homeConfigurations = {
      ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          catppuccin.homeManagerModules.catppuccin
          ags.homeManagerModules.default
          inputs.hyprpanel.homeManagerModules.hyprpanel
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit userSettings;
          inherit systemSettings;
        };
      };
    };
    devShells.${system}.default = (import ./dev.nix) pkgs;
  };
}
