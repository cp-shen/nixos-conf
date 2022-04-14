{ config, lib, pkgs, ... }:

{
  xdg.configFile."polybar".source = ./config/polybar;
  home.packages = [ pkgs.polybarFull ];
}
