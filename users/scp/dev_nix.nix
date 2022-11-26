{ config, lib, pkgs, ... }:

{

  home.packages = with pkgs; [
    nix-ld
    nix-index
    nixfmt

    appimage-run
    binutils
    dpkg
    patchelf
  ];
}
