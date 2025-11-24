{
  config,
  lib,
  pkgs,
  mkOutLink,
  userConfDir,
  ...
}:

{
  home.packages = with pkgs; [
    # generic utils
    peaclock
    cloc
    ffmpeg
    # system info utils
    glances
    lm_sensors
    intel-gpu-tools
    # desktop integration CLI utils
    pulsemixer
    xclip
    xorg.xmessage
    # scripting utils
    nodejs
    lua5_4
    lua-language-server
    shellcheck
    sqlite
    # zip utils
    unrar
    p7zip
    zip
    gzip
    # latex and math (extremely large!)
    # pkgs.texlive.combined.scheme-full sage
    # aspell
    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        en-science
      ]
    ))
    tree-sitter
    # static site generators
    hugo
    zola
  ];

  programs.yt-dlp.enable = true;
  programs.nnn.enable = true;
  programs.bottom.enable = true;
  programs.pandoc.enable = true;

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  xdg.configFile."yazi".source = mkOutLink "${userConfDir}/yazi";

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    configPath = "$HOME/.config/starship/starship.toml";
  };

  home.sessionVariables.STARSHIP_CONFIG = "$HOME/.config/starship/starship.toml";
  xdg.configFile."starship".source = mkOutLink "${userConfDir}/starship";

  programs.fzf.enable = true;
  programs.fzf.fileWidgetCommand = config.programs.fzf.defaultCommand;
  programs.fzf.defaultCommand = "fd --no-ignore --hidden -E .cache -E .git -E tags -tf -td -- . ./";
  programs.fzf.changeDirWidgetCommand = "fd --no-ignore --hidden -E .cache -E .git -E tags -td -- . $HOME";

  programs.gh.enable = true;
  programs.gh.gitCredentialHelper.enable = true;
  programs.gh.settings.git_protocol = "https";

  programs.git.enable = true;
  programs.lazygit.enable = true;
  programs.git.lfs.enable = true;
  programs.gitui.enable = true;

  xdg.configFile."bottom".source = mkOutLink "${userConfDir}/bottom";
  home.file.".gitconfig".source = mkOutLink "${userConfDir}/gitconfig";
  home.file.".peaclock".source = mkOutLink "${userConfDir}/peaclock";
}
