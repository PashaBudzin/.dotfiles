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
    # stylix = {
    #   url = "nix-community/stylix";
    #   inputs.stylix.follows = "nixpkgs";
    # };
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... }@inputs:
    let
      settings = import ./settings.nix { pkgs = pkgs; };
      systemSettings = settings.systemSettings;
      userSettings = settings.userSettings;

      system = systemSettings.system;

      pkgs = import nixpkgs { inherit system; };
    in {
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
      # homeConfigurations = {
      #   ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs;
      #     modules = [ ./home.nix ];
      #     extraSpecialArgs = {
      #       inherit inputs;
      #       inherit userSettings;
      #       inherit systemSettings;
      #     };
      #   };
      # };
    };
}
