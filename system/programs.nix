{pkgs, ...}: {
  environment.defaultPackages = with pkgs; [
    bottles
  ];
}
