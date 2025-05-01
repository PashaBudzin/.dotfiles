{ config, pkgs, systemConfig, lib, ... }:

{ config = lib.mkMerge [
    (lib.mkIf systemConfig.enableVirtualization {
      virtualisation.libvirtd.enable = true;

      users.users.yourUsername.extraGroups = [  ];

      environment.systemPackages = with pkgs; [
        virt-manager
        virt-viewer
        qemu
        dnsmasq
        ebtables
        bridge-utils
      ];
    })
  ];
}
