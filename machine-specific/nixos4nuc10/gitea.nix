{ config, lib, pkgs, ... }:

let
  fqdn = config.networking.fqdn;
in {
  services.gitea = rec {
    enable = true;
    package = pkgs.nixos24.gitea;
    lfs.enable = true;

    settings.server = rec {
      DOMAIN = "gitea.lan";
      HTTP_PORT = 8093;
      HTTP_ADDR = "127.0.0.1";
      ROOT_URL = "http://" + DOMAIN;
    };

    # extraConfig = ''
    # [packages]
    # CHUNKED_UPLOAD_PATH = "${config.services.gitea.stateDir}/tmp/package-upload";
    # '';

    database = {
      type = "postgres";
      passwordFile = "/keys/gitea-dbpassword";
      createDatabase = true;
    };
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
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
