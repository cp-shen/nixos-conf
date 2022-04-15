{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
  [ arandr dconf nitrogen picom polybarFull unclutter ];

  # config for desktop utilitied
  xdg.configFile."nitrogen".source = ./config/nitrogen;
  xdg.configFile."picom".source = ./config/picom;

  # xinit config
  home.file.".xinitrc".text = ''
    #!/bin/sh
    xsetroot -cursor_name left_ptr
    xset s off -dpms
    nitrogen --restore
    unclutter &
    picom &
    alacritty &
    exec ~/.xmonad/xmonad-x86_64-linux
  '';

  # i3 window manager
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };
  xdg.configFile."i3".source = ./config/i3;

  # status bar configs
  xdg.configFile."polybar".source = ./config/polybar;
  programs.i3status-rust.enable = true;
  programs.i3status-rust.bars = {};
  xdg.configFile."i3status-rust".source = ./config/i3status-rust;

  # xcursot theme
  xsession.pointerCursor = {
    defaultCursor = "left_ptr";
    package = pkgs.numix-cursor-theme;
    name = "Numix-Cursor";
    size = 16;
  };

  # gtk theme and icon theme
  gtk = {
    enable = true;
    iconTheme = {
      #package = pkgs.numix-icon-theme;
      #name = "Numix";
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    theme = {
      #package = pkgs.numix-gtk-theme;
      #name = "Numix";
      package = pkgs.gnome.gnome-themes-extra;
      name = "Adwaita-dark";
    };
  };

  # qt theme
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
}
