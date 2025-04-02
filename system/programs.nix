{pkgs, ...}: {
  environment.defaultPackages = with pkgs; [
    bottles
  ];

  services.zerotierone.enable = true;
  networking.firewall.allowedUDPPorts = [4230];
  networking.firewall.allowedTCPPorts = [4230];
}
