{ config, pkgs, ... }:

{
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot";
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 10;
    supportedFilesystems = [ "ntfs" ];
  };
}
