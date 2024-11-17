{ config, lib, pkgs, ... }:

let
  fqdn = config.networking.fqdn;
in {
  services.gitea = rec {
    enable = true;
    lfs.enable = true;
    domain = fqdn;
    httpPort = 3000;
    rootUrl = "http://" + fqdn + ":" + (toString httpPort);
  };
}
