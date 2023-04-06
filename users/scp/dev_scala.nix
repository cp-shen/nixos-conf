{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    (scala-cli.override { jre = pkgs.jdk17; })
    (coursier.override { jre = pkgs.jdk17; })
    (sbt.override { jre = pkgs.jdk17; })
    (mill.override { jre = pkgs.jdk17; })
    clang
  ];
}
