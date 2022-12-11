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

    cachix
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
