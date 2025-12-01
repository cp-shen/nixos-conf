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
    ## terminals
    alacritty
    # ghostty
    # kitty
    ## browsers
    firefox
    google-chrome
    ## misc
    qdirstat
    gnome-chess
  ];

  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true; 
  };

  xdg.configFile."alacritty".source = mkOutLink "${userConfDir}/alacritty";
  xdg.configFile."kitty".source = mkOutLink "${userConfDir}/kitty";
  xdg.configFile."wezterm".source = mkOutLink "${userConfDir}/wezterm";

  programs.mpv.enable = true;
  xdg.configFile."mpv/mpv.conf".text = ''
    hwdec=auto-safe
    vo=gpu
    profile=gpu-hq
    volume=60
  '';
  xdg.configFile."mpv/scripts".source = mkOutLink "${userConfDir}/mpv-scripts";

  # programs.obs-studio = {
  #   enable = true;
  # };

  programs.rofi = {
    enable = true;
    font = "Ubuntu 14";
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./config/rofi/breeze-light.rasi;

    extraConfig = {
      modes = "window,windowcd,drun";
      case-sensitive = false;
      click-to-exit = true;
      cycle = true;
      disable-history = true;
      show-icons = true;
      sort = false;
      window-thumbnail = false;

      kb-clear-line = "Control+w";
      kb-cancel = "Escape,Super+Delete,Super+Tab,Control+g";

      kb-select-1 = "Control+1";
      kb-select-2 = "Control+2";
      kb-select-3 = "Control+3";
      kb-select-4 = "Control+4";
      kb-select-5 = "Control+5";
      kb-select-6 = "Control+6";
      kb-select-7 = "Control+7";
      kb-select-8 = "Control+8";
      kb-select-9 = "Control+9";
      kb-select-10 = "Control+0";
    };
  };
}
