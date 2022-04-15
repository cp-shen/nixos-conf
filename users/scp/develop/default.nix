{ config, lib, pkgs, ... }:

{
  imports = [
    ./haskell.nix
    ./rust.nix
  ];
}
