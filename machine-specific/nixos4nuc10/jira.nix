{ config, lib, pkgs, ... }:

{
  services.jira = {
    enable = true;
    listenPort = 8091;
    listenAddress = "127.0.0.1";
    jrePackage = pkgs.nixos24.temurin-bin-11;
    # proxy = {
    # enable = true;
    # secure = true;
    # scheme = "https";
    # port = 443;
    # name = "jira.lan";
    # };
  };

  services.postgresql = {
    enable = true;
    initialScript = pkgs.writeText "psql-init" ''
      CREATE ROLE jiradb WITH LOGIN PASSWORD 'jiradb' CREATEDB;
      CREATE DATABASE jiradb WITH ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' TEMPLATE template0;
      GRANT ALL PRIVILEGES ON DATABASE jiradb TO jiradb;
    '';
  };

  services.nginx = {
    enable = true;
    enableReload = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
  services.nginx.virtualHosts."jira.lan" = {
    # enableACME = true;
    # forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8091";
      proxyWebsockets = true;
      extraConfig = "proxy_ssl_server_name on;"
        + "proxy_pass_header Authorization;";
    };
  };
  services.nginx.virtualHosts."bitbucket.lan" = {
    # enableACME = true;
    # forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:7990";
      proxyWebsockets = true;
      extraConfig = "proxy_ssl_server_name on;"
        + "proxy_pass_header Authorization;";
    };
  };

  # security.acme = {
  #   acceptTerms = true;
  #   defaults = {
  #     email = "foo@bar.com";
  #   };
  # };
}
