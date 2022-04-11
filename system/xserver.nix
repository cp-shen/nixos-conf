{ config, pkgs, ... }:

{
  environment.pathsToLink = [ "/libexec" ]; # Required by i3blocks

  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;
    windowManager.xmonad.enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [ i3blocks ];
    };
  };
}
