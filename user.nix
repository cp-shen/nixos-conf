{ config, lib, pkgs, userName, ... }:

{
  users.users."${userName}" = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.users."${userName}" = {
    imports = [ (./. + "/users/${userName}") ];
  };
}
