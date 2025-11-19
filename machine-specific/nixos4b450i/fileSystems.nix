{ config, pkgs, ... }:

{
  swapDevices = [ ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/6b11fb39-209d-4bbc-b7d9-0b9071bc7271";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/E7E7-1953";
      fsType = "vfat";
    };

    "/mnt" = {
      device = "dev/disk/by-uuid/0d6c4994-2940-41f1-bf1d-2f0aa2f6353c";
      fsType = "ext4";
    };

    "/mnt1" = {
      device = "/dev/disk/by-uuid/3E3C68E73C689C21";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "gid=100" ];
    };

    #nfs
    "/export/bt" = {
      device = "/mnt1/BT";
      options = [ "bind" ];
    };

    #nfs
    "/export/yt-dlp" = {
      device = "/mnt1/yt-dlp";
      options = [ "bind" ];
    };
  };

  services.nfs.server = {
    enable = true;
    exports =
    ''
      /export            *(fsid=0,sync,insecure,no_subtree_check)
      /export/bt         *(nohide,sync,insecure,no_subtree_check)
      /export/yt-dlp     *(nohide,sync,insecure,no_subtree_check)
    '';
  };
}
