{ config, pkgs, ... }:

{
  programs.sway.enable = true;
  programs.waybar.enable = true;

  programs.niri.enable = true;
  programs.niri.package = pkgs.nixos25.niri;

  programs.xwayland.enable = true; 

  services.xserver = {
    enable = true;
    autorun = false;

    # windowManager.i3 = {
    #   enable = true;
    #   package = pkgs.i3-gaps;
    # };

    # windowManager.xmonad = {
    #   enable = true;
    #   enableContribAndExtras = true;
    # };

    displayManager.startx.enable = true;
  };
}
