{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    autorun = false;

    # windowManager.i3 = {
    #   enable = true;
    #   package = pkgs.i3-gaps;
    # };

    displayManager.startx.enable = true;
  };
}
