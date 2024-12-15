{ config, lib, pkgs, userName, inputs, ... }:

let homeDir = "/home/${userName}";
in {
  users.users."${userName}" = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    home = homeDir;
  };

  home-manager.users."${userName}" = ({ config, lib, ... }: {
    imports = [ (./. + "/users/${userName}") ];
    _module.args = {
      inherit userName;
      mkOutLink = config.lib.file.mkOutOfStoreSymlink;
      userConfDir = "${homeDir}/nixos/users/${userName}/config";
    };
  });
}
