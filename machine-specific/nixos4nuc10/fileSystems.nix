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

    "/mnt1" = {
      device = "/dev/disk/by-uuid/72ed0876-b136-4b4b-9d99-e16173b459fc";
      fsType = "ext4";
    };

    "/mnt2" = { 
      device = "/dev/disk/by-uuid/2420C99120C96A7E";
      fsType = "ntfs3";
      options = ["rw" "uid=1000" "gid=100"];
    };

    "/mnt3" = { 
      device = "/dev/disk/by-uuid/263897C938979681";
      fsType = "ntfs3";
      options = ["rw" "uid=1000" "gid=100"];
    };

    "/mnt4" = { 
      device = "/dev/disk/by-uuid/E408E41708E3E710";
      fsType = "ntfs3";
      options = ["rw" "uid=1000" "gid=100"];
    };

    #nfs
    "export/downloads" = {
      device = "/home/scp/Downloads";
      options = [ "bind" ];
    };

    #nfs
    "export/mnt2" = {
      device = "/mnt2/Users/Admin/Downloads/BtDownload";
      options = [ "bind" ];
    };
  };

  services.nfs.server = {
    enable = true;
    exports =
    ''
      /export            *(fsid=0,sync,insecure,no_subtree_check)
      /export/downloads  *(nohide,sync,insecure,no_subtree_check)
      /export/mnt2       *(nohide,sync,insecure,no_subtree_check)
    '';
  };
}
