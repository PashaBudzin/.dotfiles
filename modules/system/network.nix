{ lib, config, ... }:

with lib;

{
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 3773 ];
    allowedTCPPorts = [ 3773 ];
  };

  services.tailscale = {
    enable = true;
  };

}
