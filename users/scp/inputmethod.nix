{ config, lib, pkgs, ... }:

{
  # i18n.inputMethod = {
  #   enabled = "fcitx5";
    # fcitx.engines = with pkgs.fcitx-engins; [rime mozc];

    # fcitx5.addons = with pkgs; [fcitx5-rime fcitx5-mozc];
    # fcitx5.enableRimeData = true;
  # };

  #xdg.configFile."fcitx5" = {
  #  source = ./config/fcitx5;
  #  recursive = true;
  #};
}
