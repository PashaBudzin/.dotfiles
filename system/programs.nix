{ pkgs, ... }: {
  environment.defaultPackages = with pkgs; [ bottles ffmpeg imagemagick jq ];

  services.zerotierone.enable = true;
  networking.firewall.allowedUDPPorts = [ 4230 ];
  networking.firewall.allowedTCPPorts = [ 4230 ];
}
