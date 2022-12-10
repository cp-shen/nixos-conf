{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay.url = "github:oxalica/rust-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, rust-overlay,
             emacs-overlay, neovim-nightly-overlay, ... }:
    let
      system = "x86_64-linux";
      myHostNames = {
        "nixos4b450i" = { };
        "nixos4nuc10" = { };
      };
      myUserName = "scp";

      mkSystem = userName: hostName: _:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            {
              networking.hostName = hostName;
              nixpkgs.overlays = [
                neovim-nightly-overlay.overlay
                rust-overlay.overlays.default
                emacs-overlay.overlays.default
              ];
            }
            ./system
            (./. + "/machine-specific/${hostName}")
            (./. + "/users/${userName}")
          ];
        };
    in {
      nixosConfigurations = builtins.mapAttrs (mkSystem myUserName) myHostNames;
    };
}
