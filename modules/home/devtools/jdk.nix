{ pkgs }: {
  home.packages = with pkgs; [
    kotlin-language-server
    ktfmt
    google-java-format
    jdt-language-server
  ];
}
