{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { 
    nixpkgs, 
    home-manager, 
    ... }: 
  let
    system = "x86_64-linux";
    myHostNames = {
      "nixos4b450i" = {};
      "nixos4nuc10" = {};
    };
    myUserName = "scp";

    mkSystem = userName: hostName: _:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ 
          { networking.hostName = hostName; } 
          ./system
          (./. + "/machine-specific/${hostName}")
          (./. + "/users/${userName}")
        ];
      };
  in 
  { nixosConfigurations = builtins.mapAttrs (mkSystem myUserName) myHostNames; };
}
