{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.go.enable = true;
  programs.go.env.GOPATH = "${config.home.homeDirectory}/go";

  # home.packages = with pkgs; [
  #   gore
  #   gocode
  #   gotests
  #   gomodifytags
  #   gotools
  #   gopls
  # ];
}
