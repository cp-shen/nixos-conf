{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # editor
    neovim-unwrapped
    # download tools
    aria curl wget
    # basic toolchains
    gcc gnumake cmake libtool
    # partitioning tools
    parted gparted
    # system utilities
    htop file fd procs ripgrep tree unzip
  ];

  programs = {
    git.enable = true;
    less.enable = true;
    zsh.enable = true;
  };
}
