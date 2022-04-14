{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModule ];

  users.users.scp = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.scp = { pkgs, ... }: {
    imports = [
      ./fzf.nix
      ./i3.nix
      ./misc.nix
      ./polybar.nix
      ./zsh.nix
    ];

    home.packages = with pkgs; [
      # haskell toolchains
      ghc stack cabal-install haskell-language-server
      haskellPackages.implicit-hie haskellPackages.hoogle

      arandr unclutter nitrogen picom # desktop environment
      alacritty kitty # terminals
      firefox google-chrome # browsers
      termdown cloc # CLI tools
      clash # network proxy
      glances # sys monitor
      pulsemixer # audio tools
      glxinfo # opengl test tools

      # xmonad build and runtime deps
      # pkgconf xorg.xmessage xorg.libX11 xorg.libXft xorg.libXinerama xorg.libXrandr
    ];
  };
}
