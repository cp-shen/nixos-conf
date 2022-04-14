{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.dconf ];

  xsession.pointerCursor = {
    defaultCursor = "left_ptr";
    package = pkgs.numix-cursor-theme;
    name = "Numix-Cursor";
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
  qt = {
    enable = true;
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
}
