{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # editor
    nixos24.neovim-unwrapped # neovim-nightly
    nixos25.zed-editor-fhs
    # download tools
    aria
    curl
    wget
    # basic toolchains
    gcc
    gcc_multi
    gnumake
    cmake
    ninja
    libtool
    # partitioning tools
    parted
    gparted
    # system utilities
    htop
    file
    fd
    procs
    ripgrep
    tree
    unzip
  ];

  services.qbittorrent.enable = true;
  services.qbittorrent.user = "scp";
  services.qbittorrent.group = "users";
  services.clash.enable = true;

  services.nginx = {
    enable = true;
    enableReload = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_13;
  };

  programs = {
    git.enable = true;
    less.enable = true;
    zsh.enable = true;
    # java.enable = true;
    # java.package = pkgs.jdk17;
  };

  # environment.variables.JAVA_HOME = "${config.programs.java.package.home}";
  # environment.variables.JAVA_OPTS =
  #   "-Xmx2048m -Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=7890 -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=7890";
}
