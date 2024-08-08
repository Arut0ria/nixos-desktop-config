{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # disko = {
    #  url = "github:nix-community/disko";
    #  inputs.nixpkgs.follows = "nixpkgs";
    # };
    
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs system;
      };
      
      modules = [
        ./hosts/desktop/configuration.nix
        ./nixosModules
        inputs.stylix.nixosModules.stylix
      ];
    };

    homeManagerModules.default = ./homeManagerModules;
  };
}
