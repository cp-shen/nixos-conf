{ config, lib, pkgs, ... }:

{
  # Note: use flake.nix in projects, remove global interpreter
  #
  # home.packages = with pkgs;
  # let
  #   my-python-packages = python-packages: with python-packages; [
  #     numpy
  #     sympy
  #   ];
  #   python-with-my-packages = python3.withPackages my-python-packages;
  # in
  # [ python-with-my-packages ];
}
