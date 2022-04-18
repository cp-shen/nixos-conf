{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # terminals
    alacritty kitty
    # browsers
    firefox google-chrome
    # bt downloader
    qbittorrent qbittorrent-nox
    # misc
    rhythmbox gnome.gedit
  ];

  xdg.configFile."alacritty".source = ./config/alacritty;
  xdg.configFile."kitty".source = ./config/kitty;

  programs.mpv.enable = true;
  programs.mpv.scripts = with pkgs; [ mpvScripts.mpv-playlistmanager ];

  services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
}
