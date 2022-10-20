{ config, lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # nerd patched fonts
    (pkgs.nerdfonts.override {
        fonts = [ "FiraCode" "Ubuntu" "CascadiaCode" "Hack"]; })

    # programming fonts
    fira-code
    fira-code-symbols
    hack-font
    dejavu_fonts
    cascadia-code

    # other fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    material-icons
    ubuntu_font_family
  ];
}
