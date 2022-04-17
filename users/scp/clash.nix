{ config, lib, pkgs, ... }:

{
  systemd.user.services.clash = {
    Unit.Description = "Clash a porxy tool";
    Unit.After = [ "network.target" ];
    Install.WantedBy = [ "default.target" ];

    Service = {
      Type = "exec";
      Restart = "on-abort";
      ExecStart = "${pkgs.clash}/bin/clash";
    };
  };
}
