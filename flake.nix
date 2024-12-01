{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # disko = {
    #  url = "github:nix-community/disko";
    #  inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

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

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland?ref=0.45.1-b";
      submodules = true;
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};

      configSharedModules = [
        ./nixosModules

        ./config/system
        ./config/home

        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
        inputs.nixvim.nixosModules.nixvim
      ];

      configSharedArgs = {
        inherit inputs system pkgs-unstable;
      };
    in
    {
      nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { hostName = "nixos-desktop"; } // configSharedArgs;

        modules = [
          ./hosts/desktop/configuration.nix
        ] ++ configSharedModules;
      };

      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { hostName = "nixos-laptop"; } // configSharedArgs;

        modules = [
          ./hosts/laptop/configuration.nix
        ] ++ configSharedModules;
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
