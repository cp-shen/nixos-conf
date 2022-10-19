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
    # latex
    pkgs.texlive.combined.scheme-full
  ];

  xdg.configFile."alacritty".source = ./config/alacritty;
  xdg.configFile."kitty".source = ./config/kitty;

  programs.mpv.enable = true;
  programs.mpv.scripts = with pkgs; [ mpvScripts.mpv-playlistmanager ];
  xdg.configFile."mpv/mpv.conf".text = ''
    hwdec=auto-safe
    vo=gpu
    profile=gpu-hq
  '';

  services.emacs.enable = false;
  # FIXME: emacs as daemon not usable now (with some environment error)
  # magit complains about empty ident
  # vterm can't init starship

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  programs.vscode = {
    enable = true;
  };
}
