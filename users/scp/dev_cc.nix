{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    clang-tools clang
    gdb cgdb
    pkg-config
    ccls
  ];
}
