{ lib, config, ... }:

with lib;

{
  networking.nftables.enable = true;

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 3773 ];
    allowedTCPPorts = [ 3773 ];

    trustedInterfaces = [ config.services.tailscale.interfaceName ];
  };

  services.tailscale = {
    enable = true;
  };

  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
}
