{ config, lib, pkgs, ... }:

{
  services.redmine = {
      enable = true;
      port = 8092;
  };

  services.nginx.virtualHosts."redmine.lan" = {
    locations."/" = { proxyPass = "http://127.0.0.1:8092"; };
    # forceSSL = true;
    # enableACME = true;
  };
}
