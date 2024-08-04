{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    /*
    home-mananger = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    */
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        inputs.disko.nixosModules.disko
      ];
    };

      /*
      homeConfigurations.theo = home-manager.lib.homeManagerConfiguration {
       inherit pkgs;
       modules = [
         ./home.nix
       ];
      };
      */
  };
}
