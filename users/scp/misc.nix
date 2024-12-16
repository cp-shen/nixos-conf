{ config, pkgs, ... }:

{
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # "inode/directory" = [ "firefox.desktop" ];
      # "text/html" = [ "firefox.desktop" ];
      # "x-scheme-handler/http" = [ "firefox.desktop" ];
      # "x-scheme-handler/https" = [ "firefox.desktop" ];
      # "x-scheme-handler/about" = [ "firefox.desktop" ];
      # "x-scheme-handler/unknown" = [ "firefox.desktop" ];

      "inode/directory" = [ "google-chrome.desktop" ];
      "text/html" = [ "google-chrome.desktop" ];
      "x-scheme-handler/http" = [ "google-chrome.desktop" ];
      "x-scheme-handler/https" = [ "google-chrome.desktop" ];
      "x-scheme-handler/about" = [ "google-chrome.desktop" ];
    };
  };

  home.sessionPath = [
    "$HOME/.npm-global/bin"
    "$HOME/.cargo/bin"
    "$HOME/.emacs.d/bin"
    "$HOME/.ghcup/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];

  home.sessionVariables = { EDITOR = "nvim"; };
}
