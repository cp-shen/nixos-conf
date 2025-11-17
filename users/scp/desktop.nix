{ config, lib, pkgs, mkOutLink, userConfDir, ... }:

{
  home.packages = with pkgs; [
    arandr dconf xfce.xfce4-screenshooter polybarFull
    unclutter-xfixes picom nitrogen feh
    # pasystray
    networkmanagerapplet
    # leftwm
    xmonad-mycfg
    fuzzel mako wlr-randr 
  ];

  # linking config files
  xdg.configFile."nitrogen".source = mkOutLink "${userConfDir}/nitrogen";
  xdg.configFile."niri".source = mkOutLink "${userConfDir}/niri";
  xdg.configFile."picom".source = mkOutLink "${userConfDir}/picom";
  xdg.configFile."i3".source = mkOutLink "${userConfDir}/i3";
  xdg.configFile."sway".source = mkOutLink "${userConfDir}/sway";
  xdg.configFile."leftwm".source = mkOutLink "${userConfDir}/leftwm";
  home.file.".xinitrc".source = mkOutLink "${userConfDir}/xinitrc";

  home.file.xmonadBuildScript = {
    target = ".xmonad/build";
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -e

      XMDIR="$HOME/xmonad-mycfg"

      cd "$XMDIR"
      nix build


      if [ "$#" -ne 0 ]; then
         echo "linking to $1"
         ln -s -f -T "$XMDIR/result/bin/xmonad" "$1"
      else
         echo "no linking needed"
      fi
    '';
  };

  # status bars
  xdg.configFile."polybar".source = mkOutLink "${userConfDir}/polybar";
  xdg.configFile."waybar".source = mkOutLink "${userConfDir}/waybar";
  programs.i3status-rust.enable = true;
  programs.i3status-rust.bars = { };
  xdg.configFile."i3status-rust".source = mkOutLink "${userConfDir}/i3status-rust";

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
      package = pkgs.libsForQt5.breeze-icons;
      name = "Breeze";
    };
    theme = {
      package = pkgs.libsForQt5.breeze-gtk;
      name = "Breeze";
    };
  };

  # qt theme
  qt = {
    enable = true;
    style.name = "Breeze";
    style.package = pkgs.libsForQt5.breeze-qt5;
  };
}
