{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  programs.ssh = {
    enableAskPassword = false;
  };
}
