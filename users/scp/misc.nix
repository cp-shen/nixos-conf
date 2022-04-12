{ config, pkgs, ... }:

{
  programs.gh.enable = true;
  programs.git.enable = true;
  home.file.".gitconfig".source = ./config/gitconfig;

  xdg.configFile."alacritty".source = ./config/alacritty;
  xdg.configFile."nitrogen".source = ./config/nitrogen;
  xdg.configFile."picom".source = ./config/picom;

  programs.mpv.enable = true;
  programs.mpv.scripts = with pkgs; [ mpvScripts.mpv-playlistmanager ];
  programs.emacs.enable = true;
}
