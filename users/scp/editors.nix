# read: https://gist.github.com/nat-418/d76586da7a5d113ab90578ed56069509

{ config, lib, pkgs, ... }:

let
  mkLink = config.lib.file.mkOutOfStoreSymlink;
  nixConfDir = "${config.home.homeDirectory}/nixos/users/${config.home.username}/config";
in {

  xdg.configFile."nvim".source = mkLink "${nixConfDir}/nvim";

}
