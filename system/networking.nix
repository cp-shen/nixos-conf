{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    proxy.default = "http://127.0.0.1:7890/";
    proxy.noProxy = "127.0.0.1,localhost,*.lan";
  
    useDHCP = true;
    domain = "lan";

    firewall.enable = false;
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
  };
}
