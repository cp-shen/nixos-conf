{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.nginx.virtualHosts."bitbucket.lan" = {
    # enableACME = true;
    # forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:7990";
      proxyWebsockets = true;
      extraConfig = "proxy_ssl_server_name on;" + "proxy_pass_header Authorization;";
    };
  };

  # ref: https://atlassian.github.io/data-center-helm-charts/containers/BITBUCKET/
  virtualisation.oci-containers.containers.bitbucket = {
    image = "atlassian/bitbucket";
    volumes = [ "/data/bitbucket:/var/atlassian/application-data/bitbucket" ];
    # ports = ["7990:7990" "7999:7999"];
    extraOptions = [ "--network=host" ];
  };
}
