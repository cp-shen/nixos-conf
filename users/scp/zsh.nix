{ pkgs, config, lib, ... }:

{
  home.packages = [ pkgs.starship ];
  xdg.configFile."starship".source = ./config/starship;
  home.sessionVariables.STARSHIP_CONFIG="$HOME/.config/starship/starship.toml";

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    defaultKeymap = "viins";

    envExtra = ''
      typeset -U PATH path

      path=("$path[@]" "$HOME/.cargo/bin")
      path=("$path[@]" "$HOME/.emacs.d/bin")
      path=("$path[@]" "$HOME/.ghcup/bin")
      path=("$path[@]" "$HOME/.local/bin")
      # path=("$path[@]" "$HOME/.scripts")

      export PATH

      export EDITOR=nvim
      export EMACS_SOCKET_NAME=/tmp/emacs1000/server
    '';
    # FIXME: remove EMACS_SOCKET_NAME?

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
      # autoload -Uz vcs_info
      # precmd_vcs_info() { vcs_info }
      # precmd_functions+=( precmd_vcs_info )
      # setopt prompt_subst
      # zstyle ':vcs_info:git:*' formats '%F{240}(%b)%f'
      # zstyle ':vcs_info:*' enable git

      # setup my custom prompt theme
      # prompt_mytheme_setup() {
      #     PS1="%F{red}%B%(?..[%?] )%b%f%n@%F{magenta}%5d%f %# "
      #     RPS1=\$vcs_info_msg_0_
      # }
      # prompt_themes+=( mytheme )
      # prompt mytheme

      n ()
      {
          # Block nesting of nnn in subshells
          if [[ "''${NNNLVL:-0}" -ge 1 ]]; then
              echo "nnn is already running"
              return
          fi

          export NNN_TMPFILE="$HOME/.config/nnn/.lastd"

          \nnn "$@"

          if [ -f "$NNN_TMPFILE" ]; then
                  . "$NNN_TMPFILE"
                  rm -f "$NNN_TMPFILE" > /dev/null
          fi
      }

      eval "$(starship init zsh)"
    '';

    shellAliases = {
      l = "ls --color -hF";
      ls = "ls --color -hF";
      ll = "ls --color -hF -l";
      la = "ls --color -hF -a";
      lla = "ls --color -hF -al";

      "..." = "cd ../../";
      ala = "alacritty";
      ec = "emacsclient -c";
      et = "TERM=xterm-direct emacsclient -t";
      du = "du -h";
      gvim = "nvim-qt --no-ext-tabline";
      grep = "grep --color";
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
      xo = "xdg-open";
    };
  };
}
