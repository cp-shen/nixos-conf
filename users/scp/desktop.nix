{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    arandr dconf xfce.xfce4-screenshooter polybarFull
    unclutter-xfixes picom nitrogen
    pasystray networkmanagerapplet
  ];

  # config for desktop utilities
  xdg.configFile."nitrogen".source = ./config/nitrogen;
  xdg.configFile."picom".source = ./config/picom;
  xdg.configFile."i3".source = ./config/i3;

  # xinit config
  home.file.".xinitrc".text = ''
    #!/bin/sh
    xsetroot -cursor_name left_ptr
    xset s off -dpms
    xrdb -merge ~/.Xresources

    nitrogen --restore
    nm-applet &
    unclutter &
    picom &
    fcitx5 &
    alacritty &

    exec $HOME/.xmonad/xmonad-x86_64-linux
  '';

  # status bar configs
  xdg.configFile."polybar".source = ./config/polybar;
  programs.i3status-rust.enable = true;
  programs.i3status-rust.bars = {};
  xdg.configFile."i3status-rust".source = ./config/i3status-rust;

  # xcursor theme
  home.pointerCursor = {
    package = pkgs.numix-cursor-theme;
    name = "Numix-Cursor";
    size = 16;

    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
  };

  # gtk theme and icon theme
  gtk = {
    enable = true;
    iconTheme = {
      # package = pkgs.numix-icon-theme;
      # name = "Numix";
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    theme = {
      # package = pkgs.numix-gtk-theme;
      # name = "Numix";
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
