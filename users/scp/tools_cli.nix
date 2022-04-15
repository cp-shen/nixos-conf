{ config, lib, pkgs, ... }:

{
    home.packages = with pkgs; [
      clash
      cloc
      glances
      glxinfo
      pulsemixer
      termdown
    ];
}
