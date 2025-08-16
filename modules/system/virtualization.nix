{ lib, pkgs, config, userSettings, ... }:

with lib;

{
  options.virtualization.qemu = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Enable QEMU/KVM virtualization with libvirt and virt-manager.
    '';
  };

  options.virtualization.waydroid = mkOption {
    type = types.bool;
    default = false;
    description = ''
      Enable Waydroid for running Android in a container.
    '';
  };

  config = mkMerge [
    (mkIf config.virtualization.qemu {
      virtualisation.libvirtd.enable = true;
      virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
      virtualisation.libvirtd.onBoot = "start";

      programs.virt-manager.enable = true;

      users.users.${userSettings.username}.extraGroups = [ "libvirtd" "kvm" ];

      environment.systemPackages = with pkgs; [
        virt-viewer
        qemu
        dnsmasq
        ebtables
        bridge-utils
      ];
    })

    (mkIf config.virtualization.waydroid {
      virtualisation.waydroid.enable = true;
    })
  ];
}
