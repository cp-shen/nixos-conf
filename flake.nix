{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs24.url = "github:nixos/nixpkgs/nixos-24.05";
    #nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #rust-overlay.url = "github:oxalica/rust-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    leftwm.url = "github:leftwm/leftwm";
    xmonad-mycfg.url = "git+file:/home/scp/xmonad-mycfg";
    xmonad-mycfg.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, ... }:
    let
      system = "x86_64-linux";
      myHostNames = {
        "nixos4b450i" = { };
        "nixos4nuc10" = { };
      };
      myUserName = "scp";
      overlay-stable = final: prev: {
        stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      overlay24 = final: prev: {
        nixos24 = import inputs.nixpkgs24 {
          inherit system;
          config.allowUnfree = true;
        };
      };
      myOverlays = [
        self.overlays.default
        overlay-stable
        overlay24
        inputs.neovim-nightly-overlay.overlays.default
        inputs.emacs-overlay.overlays.default
        inputs.leftwm.overlays.default
        inputs.xmonad-mycfg.overlays.default
        #inputs.rust-overlay.overlays.default
      ];
      mySystem = userName: hostName: _:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit userName;
          };
          modules = [
            {
              networking.hostName = hostName;
              nixpkgs.overlays = myOverlays;
            }

            home-manager.nixosModule

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }

            {
              imports = [
                ./user.nix
                ./system
                (./. + "/machine-specific/${hostName}")
              ];
            }
          ];
        };
    in {
      overlays.default = import ./overlay.nix;
      nixosConfigurations = builtins.mapAttrs (mySystem myUserName) myHostNames;
    };
}
