{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    volta
    python3
  ];

  programs.nix-ld.enable = true;
}
