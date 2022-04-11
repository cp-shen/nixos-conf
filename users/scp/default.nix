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

    xdg.configFile."alacritty".source = ./config/alacritty;
    xdg.configFile."nvim".source = ./config/nvim;

    xdg.configFile."nitrogen".source = ./config/nitrogen;
    xdg.configFile."picom".source = ./config/picom;

    programs.mpv.enable = true;
    programs.mpv.scripts = with pkgs; [ mpvScripts.mpv-playlistmanager ];

    programs.fzf.enable = true;
    programs.fzf.defaultCommand = "fd --no-ignore --hidden -E .cache -E .git -E tags -tf -td -- . ./";
    programs.fzf.fileWidgetCommand = config.home-manager.users.scp.programs.fzf.defaultCommand;
    programs.fzf.changeDirWidgetCommand = "fd --no-ignore --hidden -E .cache -E .git -E tags -td -- . $HOME";

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      defaultKeymap = "viins";
      initExtra = ''
        setopt AUTO_PUSHD
        setopt PUSHD_IGNORE_DUPS
        setopt PUSHD_SILENT

        cdUndoKey() {
          popd
          zle  reset-prompt
          print
          zle  reset-prompt
        }
        cdParentKey() {
          pushd ..
          zle  reset-prompt
          print
          zle  reset-prompt
        }
        zle -N cdParentKey
        zle -N cdUndoKey

        archwiki(){
          xdg-open "https://wiki.archlinux.org/index.php?search=$1" &!
        }
        archman(){
          xdg-open "https://man.archlinux.org/search?lang=en&q=$1" &!
        }
        archpkg(){
          xdg-open "https://archlinux.org/packages/?q=$1" &!
        }

        bindkey '^[[1;3A' cdParentKey
        bindkey '^[[1;3D' cdUndoKey

        bindkey "^[[3~" delete-char # enable delete key
        bindkey '^[[Z' reverse-menu-complete # enable shift-tab

        # enable git prompt
        autoload -Uz vcs_info
        precmd_vcs_info() { vcs_info }
        precmd_functions+=( precmd_vcs_info )
        setopt prompt_subst
        zstyle ':vcs_info:git:*' formats '%F{240}(%b)%f'
        zstyle ':vcs_info:*' enable git

        # setup my custom prompt theme
        prompt_mytheme_setup() {
            PS1="%F{red}%B%(?..[%?] )%b%f%n@%F{magenta}%5d%f %# "
            RPS1=\$vcs_info_msg_0_
        }
        prompt_themes+=( mytheme )
        prompt mytheme
      '';

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
      cloc
      firefox
      fd
      glances
      nitrogen
      picom
      pulsemixer
      ripgrep
      termdown
      unclutter
    ];
  };

}
