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
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
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

      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs system;
        };

        modules = [
          ./hosts/laptop/configuration.nix
          ./nixosModules
          inputs.stylix.nixosModules.stylix
        ];
      };

      inputs.home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        sharedModules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
        ];
      };

      homeManagerModules.default = ./homeManagerModules;
    };
}
