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
      ./desktop.nix
      ./fzf.nix
      ./i3.nix
      ./misc.nix
      ./polybar.nix
      ./zsh.nix
    ];
  };
}
