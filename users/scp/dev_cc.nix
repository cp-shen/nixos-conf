{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ccls clang-tools
    gdb cgdb
    pkg-config
  ];
}
