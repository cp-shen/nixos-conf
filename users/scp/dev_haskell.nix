{ config, lib, pkgs, ... }:

{
  # haskell toolchains
  home.packages = with pkgs; [
    ghc stack cabal-install haskell-language-server
    haskellPackages.implicit-hie haskellPackages.hoogle
    cabal2nix
  ];
}
