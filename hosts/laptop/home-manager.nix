{ inputs, pkgs, lib, config, ... }: {
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      theo = {
        imports = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          ./home.nix
          inputs.self.outputs.homeManagerModules.default
        ];
      };
    };
  };
}
