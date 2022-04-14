{ config, lib, pkgs, ... }:

{
  xsession.pointerCursor = {
    defaultCursor = "left_ptr";
    package = pkgs.numix-cursor-theme;
    name = "Numix-Cursor-Light";
    size = 16;
  };
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.numix-icon-theme;
      name = "Numix";
    };
    theme = {
      package = pkgs.numix-gtk-theme;
      name = "Numix";
    };
  };
}
