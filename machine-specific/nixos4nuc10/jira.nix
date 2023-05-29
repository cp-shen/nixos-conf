{ config, lib, pkgs, ... }:

{
  services.jira = {
    enable = true;
    listenPort = 8091;
    listenAddress = "0.0.0.0";
    jrePackage = pkgs.stable.temurin-bin-11;
  };

  services.postgresql = {
     enable = true;
     initialScript = pkgs.writeText "psql-init" ''
      CREATE ROLE jiradb WITH LOGIN PASSWORD 'jiradb' CREATEDB;
      CREATE DATABASE jiradb WITH ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' TEMPLATE template0;
      GRANT ALL PRIVILEGES ON DATABASE jiradb TO jiradb;
    '';
  };
}
