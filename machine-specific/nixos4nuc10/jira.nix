{
  config,
  lib,
  pkgs,
  ...
}:

{
  # services.jira = {
  #   enable = true;
  #   listenPort = 8091;
  #   listenAddress = "127.0.0.1";
  #   jrePackage = pkgs.nixos24.temurin-bin-11;
  # };

  # services.postgresql = {
  #   enable = true;
  #   initialScript = pkgs.writeText "psql-init" ''
  #     CREATE ROLE jiradb WITH LOGIN PASSWORD 'jiradb' CREATEDB;
  #     CREATE DATABASE jiradb WITH ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' TEMPLATE template0;
  #     GRANT ALL PRIVILEGES ON DATABASE jiradb TO jiradb;
  #   '';
  # };

  services.nginx.virtualHosts."jira.lan" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:8091";
      proxyWebsockets = true;
      extraConfig = "proxy_ssl_server_name on;" + "proxy_pass_header Authorization;";
    };
  };

  virtualisation.oci-containers.containers.jira = {
    image = "atlassian/jira-software";
    volumes = [ "/var/lib/jira:/var/atlassian/application-data/jira" ];
    extraOptions = [ "--network=host" ];

    # ref: https://atlassian.github.io/data-center-helm-charts/containers/JIRA/
    environment = {

      ATL_TOMCAT_PORT = "8091";
      ATL_TOMCAT_SCHEME = "http";

      ATL_JDBC_URL = "jdbc:postgresql://127.0.0.1:5432/jiradb";
      ATL_JDBC_USER = "jiradb";
      ATL_JDBC_PASSWORD = "jiradb";
      ATL_DB_DRIVER = "org.postgresql.Driver";
      ATL_DB_TYPE = "postgres72";
    };
  };
}
