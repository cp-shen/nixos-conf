{ config, pkgs, ... }:

{
  programs = {
    git.enable = true;
    htop.enable = true;
    less.enable = true;
    neovim.enable = true;
    zsh.enable = true;
  };
}
