{ inputs, userSettings, systemSettings, ... }:
let

in {
  imports =
    [ ./configuration.nix inputs.home-manager.nixosModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.pasha = ./home.nix;
  home-manager.extraSpecialArgs = {
    inherit inputs;
    inherit userSettings;
    inherit systemSettings;
  };
}
