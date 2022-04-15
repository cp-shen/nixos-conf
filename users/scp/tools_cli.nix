{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    clash
    cloc
    glances
    glxinfo
    nixfmt
    pulsemixer
    termdown
  ];

  programs.fzf.enable = true;
  programs.fzf.fileWidgetCommand = config.programs.fzf.defaultCommand;
  programs.fzf.defaultCommand = "fd --no-ignore --hidden -E .cache -E .git -E tags -tf -td -- . ./";
  programs.fzf.changeDirWidgetCommand = "fd --no-ignore --hidden -E .cache -E .git -E tags -td -- . $HOME";

  programs.gh.enable = true;
  programs.gh.enableGitCredentialHelper = true;
  programs.gh.settings.git_protocol = "https";

  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.gitui.enable = true;
  home.file.".gitconfig".source = ./config/gitconfig;
}
