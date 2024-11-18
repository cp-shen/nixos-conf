{ config, lib, pkgs, ... }:

let
  fqdn = config.networking.fqdn;
in {
  services.gitea = rec {
    enable = true;
    # package = pkgs.nixos24.gitea;
    lfs.enable = true;
    domain = "gitea.lan";
    httpPort = 8093;
    httpAddress = "127.0.0.1";
    rootUrl = "http://" + domain;
    database = {
      type = "postgres";
      passwordFile = "/keys/gitea-dbpassword";
      createDatabase = true;
    };
  };

  services.nginx.virtualHosts."gitea.lan" = {
    # enableACME = true;
    # forceSSL = true;
    locations."/" = {
      recommendedProxySettings = false;
      proxyPass = "http://127.0.0.1:8093";
      proxyWebsockets = true;
      extraConfig = "client_max_body_size 512M;"
        + "proxy_set_header Connection $http_connection;"
        + "proxy_set_header Upgrade $http_upgrade;"
        + "proxy_set_header Host $host;"
        + "proxy_set_header X-Real-IP $remote_addr;"
        + "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;"
        + "proxy_set_header X-Forwarded-Proto $scheme;"
        + "proxy_headers_hash_max_size 1024;";
    };
  };
}
