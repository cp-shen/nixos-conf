{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # terminals
    alacritty kitty
    # browsers
    firefox google-chrome
    # bt downloader
    qbittorrent
    # misc
    pasystray rhythmbox network-manager-applet gedit
  ];
}
