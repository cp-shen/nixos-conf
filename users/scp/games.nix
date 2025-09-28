{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # osu-lazer
    nixos25.techmino
  ];
}
