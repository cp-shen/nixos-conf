{ config, lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Ubuntu" ]; })
    fira-code
    fira-code-symbols
    font-awesome
    material-icons
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    ubuntu_font_family
  ];
}
