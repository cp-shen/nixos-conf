{ pkgs, config, ... }:

{
  programs.fzf.enable = true;
  programs.fzf.defaultCommand = "fd --no-ignore --hidden -E .cache -E .git -E tags -tf -td -- . ./";
  programs.fzf.fileWidgetCommand = config.programs.fzf.defaultCommand;
  programs.fzf.changeDirWidgetCommand = "fd --no-ignore --hidden -E .cache -E .git -E tags -td -- . $HOME";
}
