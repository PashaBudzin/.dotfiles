{ lib, config, ... }:

with lib;

{
  options = {
    networking.zerotier = mkOption {
      type = types.bool;
      default = false;
      description = "Enable ZeroTier service.";
    };

    networking.openCommonPorts = mkOption {
      type = types.bool;
      default = false;
      description = "Open common UDP/TCP ports (4230, 4321) in the firewall.";
    };
  };

  config = {
    services.zerotierone.enable = config.networking.zerotier;

    networking.firewall.allowedUDPPorts =
      lib.mkIf config.networking.openCommonPorts [ 4230 4321 88 500 3544 4500 ];
    networking.firewall.allowedTCPPorts =
      lib.mkIf config.networking.openCommonPorts [ 4230 4321 3074 ];
  };
}
