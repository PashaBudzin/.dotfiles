{
  description = "My config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    # hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    # hyprpanel.inputs.nixpkgs.follows = "nixpkgs";
    # nvim-config.url = "github:PashaBudzin/nvim-config";
    # nvim-config.inputs.nixpkgs.follows = "nixpkgs";
    # nvim-config.inputs.home-manager.follows = "home-manager";
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... }@inputs:
    let
      settings = import ./settings.nix { pkgs = pkgs; };
      systemSettings = settings.systemSettings;
      userSettings = settings.userSettings;

      lib = nixpkgs.lib;

      system = systemSettings.system;

      pkgs = import nixpkgs {
        inherit system;
        # overlays = [ inputs.hyprpanel.overlay ];
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
          modules = [ ./configuration.nix catppuccin.nixosModules.catppuccin ];
        };
        installerIso = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./iso/iso.nix ];
        };
      };
      homeConfigurations = {
        ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            catppuccin.homeModules.catppuccin
            # inputs.hyprpanel.homeManagerModules.hyprpanel
            # inputs.nvim-config.homeManagerModules.default
            inputs.zen-browser.homeModules.beta
          ];
          extraSpecialArgs = {
            inherit inputs;
            inherit userSettings;
            inherit systemSettings;
          };
        };
      };
    };
}
