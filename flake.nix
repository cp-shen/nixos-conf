{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }: 
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {

      "nixos4nuc10" = nixpkgs.lib.nixosSystem {
        modules = [
          { networking.hostName = "nixos4nuc10"; }
          home-manager.nixosModule

          ./system
          ./system/machine-specific/nuc10
          ./users/scp
        ];
        inherit system;
      };

      "nixos4b450i" = nixpkgs.lib.nixosSystem {
        modules = [
          { networking.hostName = "nixos4b450i"; }
          home-manager.nixosModule

          ./system
          ./system/machine-specific/b450i
          ./users/scp
        ];
        inherit system;
      };

    };
  };
}
