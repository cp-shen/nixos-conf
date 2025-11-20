{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages =
    with pkgs;
    let
      my-python-packages =
        python-packages: with python-packages; [
          numpy
          sympy # math utils
          black # formatter
        ];
      python-with-my-packages = python3.withPackages my-python-packages;
    in
    [ python-with-my-packages ];
}
