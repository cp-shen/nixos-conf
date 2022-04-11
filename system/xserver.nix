{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;
  };
}
