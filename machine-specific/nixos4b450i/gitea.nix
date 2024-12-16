{ config, lib, pkgs, ... }:

let
  fqdn = config.networking.fqdn;
in {
  services.gitea = rec {
    enable = true;
    package = pkgs.nixos24.gitea;
    lfs.enable = true;

    settings.server = rec {
      DOMAIN = "b450.lan";
      HTTP_PORT = 3000;
      ROOT_URL = "http://" + fqdn + ":" + (toString HTTP_PORT);
    };

  };
}
