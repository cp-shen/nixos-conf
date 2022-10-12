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
    home.stateVersion = "21.11";
    imports = [
      ./clash.nix
      ./desktop.nix
      ./dev_haskell.nix
      ./dev_rust.nix
      ./fonts.nix
      ./inputmethod.nix
      ./misc.nix
      ./tools_cli.nix
      ./tools_gui.nix
      ./zsh.nix
    ];
  };
}
