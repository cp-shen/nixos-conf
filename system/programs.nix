{ config, pkgs, ... }:

{
  programs = {
    git.enable = true;
    less.enable = true;
    zsh.enable = true;
  };
}
