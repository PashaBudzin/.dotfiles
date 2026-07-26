{ userSettings, ... }:

{
  virtualisation.docker.enable = true;
  users.users.${userSettings.username}.extraGroups = [ "docker" ];
  virtualisation.docker.storageDriver = "btrfs";
}
