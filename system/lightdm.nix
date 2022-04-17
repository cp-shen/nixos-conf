{ config, lib, pkgs, ... }:

{
  services.xserver.displayManager = {
    autoLogin = {
      enable = true;
      user = "scp";
    };
    lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        cursorTheme = {
          package = pkgs.numix-cursor-theme;
          name = "Numix-Cursor";
          size = 16;
        };
      };
    };
    defaultSession = "none+xmonad-mycfg";
    sessionCommands = ''
      xsetroot -cursor_name left_ptr
      xset s off -dpms
      xrdb -merge ~/.Xresources
    '';
    session = [{
      manage = "window";
      name = "xmonad-mycfg";
      start = ''
        $HOME/.xmonad/xmonad-x86_64-linux &
        waitPID=$!
      '';
    }];
  };
}
