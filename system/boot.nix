{ config, pkgs, ... }:

{
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot";
    loader.systemd-boot.enable = true;
    supportedFilesystems = [ "ntfs" ];
  };
}
