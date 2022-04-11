{ config, pkgs, ... }:

{
  fileSystems = {

    "/boot" = {
      device = "/dev/disk/by-uuid/A13B-6447";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/disk/by-uuid/fe81c4a7-2d20-4f62-a78f-343b9e1a1101";
      fsType = "ext4";
    };

    "/mnt" = {
      device = "/dev/disk/by-uuid/72ed0876-b136-4b4b-9d99-e16173b459fc";
      fsType = "ext4";
    };

    "/mnt2" = { 
      device = "/dev/disk/by-uuid/2420C99120C96A7E";
      fsType = "ntfs";
    };
  };
}
