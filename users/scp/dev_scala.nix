{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # use per-project flake.nix
  ];
}
