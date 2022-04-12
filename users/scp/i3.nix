{ pkgs, ... }: 

{
  programs.i3status-rust.enable = true;
  programs.i3status-rust.bars = {};
  xdg.configFile."i3status-rust".source = ./config/i3status-rust;


  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };
  xdg.configFile."i3".source = ./config/i3;

  home.file.".xinitrc".text = ''
    #!/bin/sh
    xsetroot -cursor_name left_ptr
    xset s off -dpms
    nitrogen --restore
    unclutter &
    picom &
    alacritty &
    exec i3
  '';
}

