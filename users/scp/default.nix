{ config, pkgs, inputs, ... }:

{
  home.stateVersion = "21.11";
  imports = [
    ./desktop.nix
    ./dev_cc.nix
    ./dev_dotnet.nix
    ./dev_go.nix
    ./dev_haskell.nix
    ./dev_nix.nix
    ./dev_python.nix
    ./dev_rust.nix
    ./dev_scala.nix
    ./editors.nix
    ./fonts.nix
    ./inputmethod.nix
    ./misc.nix
    ./tools_cli.nix
    ./tools_gui.nix
    ./zsh.nix
    # ./games.nix
  ];
}
