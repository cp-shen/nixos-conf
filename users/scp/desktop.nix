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
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };
}
