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

  home-manager.users.scp = {
    home.stateVersion = "21.11";
    imports = [
      ./clash.nix
      ./desktop.nix
      ./dev_cc.nix
      ./dev_go.nix
      ./dev_haskell.nix
      ./dev_nix.nix
      ./dev_python.nix
      ./dev_rust.nix
      ./fonts.nix
      ./inputmethod.nix
      ./misc.nix
      ./tools_cli.nix
      ./tools_gui.nix
      ./zsh.nix
    ] ++ (if config.networking.hostName == "nixos4b450i" then
      [ ./games.nix ]
    else
      [ ]);
  };
}
