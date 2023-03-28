{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    scala_3
    scalafmt
    scalafix
    scala-cli
    ammonite
    sbt
    metals
  ];
}
