{ config, lib, pkgs, ... }:

let
  # fqdn = let
  #   join = hostName: domain:
  #     hostName + lib.strings.optionalString (domain != null) ".${domain}";
  # in join config.networking.hostName config.networking.domain;
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
