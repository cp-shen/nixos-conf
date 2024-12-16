{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nixos-option
    nix-ld
    nix-index
    nixfmt-rfc-style
    nixpkgs-fmt

    nixd
    nil

    appimage-run
    #binutils
    dpkg
    patchelf

    cachix
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
