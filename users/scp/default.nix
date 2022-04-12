{ config, pkgs, ... }:

{
  users.users.scp = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.users.scp = { pkgs, ... }: {
    imports = [
      ./i3.nix
      ./fzf.nix
      ./zsh.nix
      ./misc.nix
    ];

    home.packages = with pkgs; [
      alacritty
      arandr
      clash
      cloc
      firefox
      fd
      glances
      google-chrome
      nitrogen
      picom
      pulsemixer
      ripgrep
      termdown
      unclutter
    ];
  };
}
