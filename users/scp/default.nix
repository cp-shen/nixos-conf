{ config, pkgs, ... }:

{
  users.users.scp = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.users.scp = {
    programs.gh.enable = true;
    programs.git.enable = true;
    home.file.".gitconfig".source = ./config/gitconfig;

    home.file.".xinitrc".source = ./config/xinitrc;

    programs.zsh = {
      enable = true;
      shellAliases = {
        l   = "ls --color -hF";
        ll  = "ls --color -hF -l";
        la  = "ls --color -hF -a";
        lla = "ls --color -hF -al";

        ala = "alacritty";
        ec = "emacsclient -c";
        et = "TERM=xterm-direct emacsclient -t";
        du = "du -h";
        gvim = "nvim-qt --no-ext-tabline";
        i3exit = "i3-msg exit";
        less = "less -R --use-color";
        m = "mkdir -p";
        nv = "nvim";
      # psuser = "ps -F -u $USER";
      # psroot = "ps -F -u root";
        psuser = "procs $USER";
        psroot = "procs root";
        ran = "ranger";
        rm = "rm -i";
        sou = "source";
        szshrc = "source ~/.zshrc";
        t = "touch";
        which = "which -as";
        xo =" xdg-open";
      };
    };

    home.packages = with pkgs; [
      alacritty
      arandr
      clash
      firefox
      fzf
      fd
      glances
      nitrogen
      picom
      ripgrep
      termdown
      unclutter
    ];
  };

}
