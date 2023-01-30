{ config, pkgs, ... }:

{
  fileSystems = {

    "/" = {
      device = "/dev/disk/by-uuid/0d6c4994-2940-41f1-bf1d-2f0aa2f6353c";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/436E-6809";
      fsType = "vfat";
    };

    "/mnt1" = {
      device = "/dev/disk/by-uuid/3E3C68E73C689C21";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "gid=100" ];
    };

  };

}