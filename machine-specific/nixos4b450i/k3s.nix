{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  networking.firewall.allowedUDPPorts = [
    # 8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];

  environment.systemPackages = with pkgs; [
    kubernetes-helm
    fluxcd
  ];

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      "--write-kubeconfig-mode=644"
    ];
    autoDeployCharts = {
      kite = {
        name = "kite";
        repo = "oci://ghcr.io/kite-org/charts/kite";
        version = "0.12.2";
        hash = "sha256-NZAWgzyqmG6fnOacnTze8ZcbqTuRAk1ogvLooVjwUtk=";
        targetNamespace = "kite-system";
        createNamespace = true;
      };
    };
  };

  systemd.services.k3s.environment = {
    HTTP_PROXY = config.networking.proxy.default;
    HTTPS_PROXY = config.networking.proxy.default;
    NO_PROXY = "127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16";
  };

  environment.variables = {
    KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };
}
