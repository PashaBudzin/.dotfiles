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

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix = {
    #   url = "nix-community/stylix";
    #   inputs.stylix.follows = "nixpkgs";
    # };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    let
      settings = import ./settings.nix { pkgs = pkgs; };
      systemSettings = settings.systemSettings;
      userSettings = settings.userSettings;

      system = systemSettings.system;

      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations = {
        lenovo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs systemSettings userSettings; };
          inherit system;
          modules = [
            ./hosts/lenovo/default.nix
            home-manager.nixosModules.home-manager
          ];
        };
      };

      darwinConfigurations = {
        m1air = inputs.darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # Apple Silicon

          specialArgs = {
            inherit inputs userSettings systemSettings;
          };

          modules = [
            ./hosts/m1air/default.nix
            inputs.home-manager.darwinModules.home-manager
          ];
        };
      };

      homeConfigurations = {
        generic-linux = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
          };

          extraSpecialArgs = {
            inherit inputs userSettings systemSettings;
          };

          modules = [
            ./hosts/generic-linux/default.nix
          ];
        };
      };
    };

}
