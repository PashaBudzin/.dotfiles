{ config, pkgs, userSettings, systemSettings, lib, ... }:

{ config = lib.mkMerge [
    (lib.mkIf systemSettings.enableVirtualization {
      virtualisation.libvirtd.enable = true;
      virtualisation.libvirtd.qemuPackage = pkgs.qemu_kvm;
      virtualisation.libvirtd.onBoot = "start";
        programs.virt-manager.enable = true;

      users.users.${userSettings.username}.extraGroups = ["libvirtd" "kvm"];

      environment.systemPackages = with pkgs; [
        virt-viewer
        qemu
        dnsmasq
        ebtables
        bridge-utils
      ];
    })
  ];
}
