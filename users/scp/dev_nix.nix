{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nixos-option
    nix-ld
    nix-tree
    nix-index
    nixfmt-rfc-style
    nixpkgs-fmt

    nixd
    nil

    appimage-run
    dpkg
    patchelf

    cachix
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
