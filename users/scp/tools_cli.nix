{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # utils
    peaclock cloc ffmpeg xplr yazi
    clash-rs glances
    # sys utils
    lm_sensors intel-gpu-tools glxinfo pulsemixer
    xclip xorg.xmessage
    # scripting
    nodejs sage lua5_4 sumneko-lua-language-server shellcheck sqlite
    # zip util
    unrar p7zip zip gzip
    # latex
    pkgs.texlive.combined.scheme-full
    # aspell
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    tree-sitter
  ];
  programs.yt-dlp.enable = true;
  programs.nnn.enable = true;
  programs.bottom.enable = true;
  programs.pandoc.enable = true;

  programs.fzf.enable = true;
  programs.fzf.fileWidgetCommand = config.programs.fzf.defaultCommand;
  programs.fzf.defaultCommand = "fd --no-ignore --hidden -E .cache -E .git -E tags -tf -td -- . ./";
  programs.fzf.changeDirWidgetCommand = "fd --no-ignore --hidden -E .cache -E .git -E tags -td -- . $HOME";

  programs.gh.enable = true;
  programs.gh.enableGitCredentialHelper = true;
  programs.gh.settings.git_protocol = "https";

  programs.git.enable = true;
  programs.lazygit.enable = true;
  programs.git.lfs.enable = true;
  programs.gitui.enable = true;
  home.file.".gitconfig".source = ./config/gitconfig;

  home.file.".peaclock/config".source = ./config/peaclock/config;
}
