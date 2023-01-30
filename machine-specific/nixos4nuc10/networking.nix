{ config, lib, pkgs, ... }:

{
  networking.extraHosts = ''
    192.168.2.101 nixos4b450i.xyz
  '';
}
