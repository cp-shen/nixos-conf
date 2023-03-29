{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #rust-overlay.url = "github:oxalica/rust-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    leftwm.url = "github:leftwm/leftwm";
    xmonad-mycfg.url = "path:/home/scp/xmonad-mycfg";
    xmonad-mycfg.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
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
                inputs.neovim-nightly-overlay.overlay
                inputs.emacs-overlay.overlays.default
                inputs.leftwm.overlay
                inputs.xmonad-mycfg.overlay
                #inputs.rust-overlay.overlays.default
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
