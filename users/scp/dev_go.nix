{ config, lib, pkgs, ... }:

{
  programs.go.enable = true;
  programs.go.goPath = "go";

  # home.packages = with pkgs; [
  #   gore
  #   gocode
  #   gotests
  #   gomodifytags
  #   gotools
  #   gopls
  # ];
}
