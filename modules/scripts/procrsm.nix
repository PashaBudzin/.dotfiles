{ pkgs, ... }:

let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [ termplotlib psutil ]);

  myPythonApp = pkgs.writeScriptBin "procrsm" ''
    #!${pythonEnv}/bin/python
    ${builtins.readFile ./procrsm.py}
  '';
in { home.packages = [ myPythonApp ]; }
