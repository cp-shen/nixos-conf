{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModule ];

  users.users.scp = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.scp = { pkgs, ... }: {
    imports = [
      ./fzf.nix
      ./i3.nix
      ./misc.nix
      ./zsh.nix
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
      procs
      pulsemixer
      ripgrep
      termdown
      unclutter
    ];
  };
}
