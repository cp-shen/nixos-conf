{ config, lib, pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx.engines = with pkgs.fcitx-engins; [rime];
    fcitx5.enableRimeData = true;
    fcitx5.addons = with pkgs; [fcitx5-rime];
  };
}
