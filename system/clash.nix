# see:
#   https://github.com/icebox-nix/netkit.nix
#   https://wiki.archlinux.org/title/Systemd

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.services.clash;
  clashUserName = "clash";
  clashGroupName = "clash";
  clashModule = types.submodule {
    options = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Clash transparent proxy module.";
      };

      dashboard.port = mkOption {
        type = types.port;
        default = 3333;
        description = "Port for YACD dashboard to listen on.";
      };
    };
  };
in {
  options.services.clash = mkOption {
    type = clashModule;
    default = { };
    description = "Clash system service related configurations";
  };

  config = mkIf (cfg.enable) {
    services.lighttpd = {
      enable = true;
      port = cfg.dashboard.port;
      document-root = "${pkgs.yacd}/bin";
    };

    users.users.${clashUserName} = {
      description = "Clash deamon user";
      isSystemUser = true;
      group = "clash";
    };
    users.groups.${clashGroupName} = { };

    systemd.services.clash = {
      description = "Clash a porxy tool";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "exec";
        User = clashUserName;
        ExecStart = "${pkgs.clash}/bin/clash -d /etc/clash";
        Restart = "on-abort";
      };
    };

  };
}
