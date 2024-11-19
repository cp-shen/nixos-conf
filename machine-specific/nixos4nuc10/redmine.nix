{ config, lib, pkgs, ... }:

{
  services.redmine = {
    enable = true;
    port = 8092;
    components.git = true;
  };

  services.nginx.virtualHosts."redmine.lan" = {
    locations."/" = { proxyPass = "http://127.0.0.1:8092"; };
  };

  systemd.services."redmine-update-git-repos" =
    let cfg = config.services.redmine;
    in {
      path = [
        pkgs.wget
        pkgs.git
        cfg.package
      ];
      serviceConfig = {
        Type = "oneshot";
        User = cfg.user;
        Group = cfg.group;
        WorkingDirectory = "${cfg.stateDir}";
      };
      script = ''
        mkdir -p git_repos

        cd git_repos

        dirlist=$(find -mindepth 1 -maxdepth 1 -type d)

        for dir in $dirlist
        do
          git -C $dir fetch --prune --all
        done

        key=$(cat /keys/redmine-repo-service-key)
        wget "http://redmine.lan/sys/fetch_changesets?key=$key"
      '';
    };

  systemd.timers."redmine-update-git-repos" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnStartupSec = "2m";
      OnUnitInactiveSec = "2m";
    };
  };
}
