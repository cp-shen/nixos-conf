{ config, lib, pkgs, ... }:

let
  fqdn = config.networking.fqdn;
in {
  services.gitea = rec {
    enable = true;
    lfs.enable = true;
    domain = "b450.lan";
    httpPort = 3000;
    rootUrl = "http://" + fqdn + ":" + (toString httpPort);
  };
}
