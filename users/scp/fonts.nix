{ config, lib, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # nerd patched fonts
    (pkgs.nerdfonts.override {
        fonts = [ "FiraCode" "CascadiaCode" "Hack" "Ubuntu"]; })

    # programming fonts
        fira-code fira-code-symbols
        # chars: good-looking but sharp (has serif) (like 'g', 'r')
        # height: medium line spacing
        # (44 lines cascadia-code/hack -> 42 lines fira code -> 39 lines jb mono)
        # ligaratures: yes, italics: no, zero: slashed
        cascadia-code
        # chars: good-looking, not as sharp as fira code
        # height: small line spacing
        # ligaratures: yes, italics: yes, zero: dotted
        jetbrains-mono
        # chars: really smooth and rounded
        # height: large line spacing
        # ligaratures: yes, italics: yes, zero: dotted
        hack-font
        # chars: also smooth and rounded
        # height: small line spacing
        # ligaratures: no, italics: yes, zero: dotted

    # other fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    material-icons
    ubuntu_font_family
  ];
}
