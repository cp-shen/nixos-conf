{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs24.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs25.url = "github:nixos/nixpkgs/nixos-25.05";
    # nixpkgs25.url = "git+https://github.com/nixos/nixpkgs.git?ref=nixos-unstable&rev=b599843bad24621dcaa5ab60dac98f9b0eb1cabe"; (Sep 9, 2025)

    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # rust-overlay.url = "github:oxalica/rust-overlay";
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # emacs-overlay.url = "github:nix-community/emacs-overlay";
    # leftwm.url = "github:leftwm/leftwm";

    # xmonad-mycfg.url = "git+file:/home/scp/xmonad-mycfg";
    # xmonad-mycfg.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      myHostNames = {
        "nixos4b450i" = { };
        "nixos4nuc10" = { };
      };
      myUserName = "scp";
      overlay24 = final: prev: {
        nixos24 = import inputs.nixpkgs24 {
          inherit system;
          config.allowUnfree = true;
        };
      };
      overlay25 = final: prev: {
        nixos25 = import inputs.nixpkgs25 {
          inherit system;
          config.allowUnfree = true;
        };
      };
      myOverlays = [
        overlay24
        overlay25

        # inputs.xmonad-mycfg.overlays.default
        # inputs.neovim-nightly-overlay.overlays.default
        # inputs.emacs-overlay.overlays.default
        # inputs.leftwm.overlays.default
        # inputs.rust-overlay.overlays.default
        self.overlays.default
      ];
      mySystem =
        userName: hostName: _:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit userName;
          };
          modules = [
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              networking.hostName = hostName;
              nixpkgs.overlays = myOverlays;
            }

            {
              imports = [
                ./user.nix
                ./system
                ./machine-specific/${hostName}
                home-manager.nixosModules.home-manager
              ];
            }
          ];
        };
    in
    {
      overlays.default = import ./overlay.nix;
      nixosConfigurations = builtins.mapAttrs (mySystem myUserName) myHostNames;
      formatter.${system} = pkgs.nixfmt-tree;
      devShells.${system}.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          nixfmt-rfc-style
          nixfmt-tree
        ];
      };
    };
}
