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

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
