{ pkgs, config, lib, mkOutLink, userConfDir, ... }:

{
  home.packages = [ pkgs.starship ];
  xdg.configFile."starship".source = mkOutLink "${userConfDir}/starship";
  home.sessionVariables.STARSHIP_CONFIG="$HOME/.config/starship/starship.toml";

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    autocd = true;
    defaultKeymap = "viins";

    loginExtra = ''
      if [ -z "''${DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
        exec startx
      fi
    '';

    envExtra = ''

    '';

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

      # nnn shortcut
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

      nixify() {
        if [ ! -e ./.envrc ]; then
          echo "use nix" > .envrc
          direnv allow
        fi
        if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
          cat > default.nix <<'EOF'
      with import <nixpkgs> {};
      mkShell {
        nativeBuildInputs = [
          bashInteractive
        ];
      }
      EOF
          ''${EDITOR:-vim} default.nix
        fi
      }

      flakify() {
        if [ ! -e flake.nix ]; then
          nix flake new -t github:nix-community/nix-direnv .
        elif [ ! -e .envrc ]; then
          echo "use flake" > .envrc
          direnv allow
        fi
        ''${EDITOR:-vim} flake.nix
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
      du10 = "du --block-size=1048576 -d1 | sort -n -r | head -n 10";
      gvim = "nvim-qt --no-ext-tabline";
      grep = "grep --color";
      i3exit = "i3-msg exit";
      less = "less -R --use-color";
      m = "mkdir -p";
      nix-ls-gclinks = "find -H /nix/var/nix/gcroots/auto -type l | xargs -I {} sh -c 'readlink {}; realpath {}; echo'";
      nv = "nvim";
      # psuser = "ps -F -u $USER";
      # psroot = "ps -F -u root";
      psuser = "procs $USER";
      psroot = "procs root";
      # ran = "ranger";
      # rm = "rm -i";
      sou = "source";
      szshrc = "source ~/.zshrc";
      t = "touch";
      which = "which -as";
      xo = "xdg-open";
    };
  };
}
