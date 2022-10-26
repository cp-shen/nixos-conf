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

  programs.rofi = {
    enable = true;
    font = "Ubuntu 14";
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./config/rofi/breeze-light.rasi;

    extraConfig = {
      case-sensitive = false;
      click-to-exit = true;
      cycle = true;
      disable-history = true;
      show-icons = true;
      sort = false;
      window-thumbnail = false;

      kb-clear-line = "Control+w";
      kb-cancel = "Escape,Super+Delete,Super+Tab,Control+g";

      kb-select-1  = "Control+1";
      kb-select-2  = "Control+2";
      kb-select-3  = "Control+3";
      kb-select-4  = "Control+4";
      kb-select-5  = "Control+5";
      kb-select-6  = "Control+6";
      kb-select-7  = "Control+7";
      kb-select-8  = "Control+8";
      kb-select-9  = "Control+9";
      kb-select-10 = "Control+0";
    };
  };
}
