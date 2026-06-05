{
  inputs,
  userSettings,
  systemSettings,
  pkgs,
  ...
}:

{
  system.stateVersion = 4;

  users.users."natalabudzina" = {
    home = "/Users/natalabudzina";
  };

  ids.gids.nixbld = 350;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${userSettings.username} = import ./home.nix;

  home-manager.extraSpecialArgs = {
    inherit inputs userSettings systemSettings;
  };

  environment.systemPackages = with pkgs; [
    nh
  ];

  environment.variables = {
    NH_FLAKE = "${userSettings.flakeDir}";
  };
}
