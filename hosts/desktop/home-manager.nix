{ inputs, pkgs, lib, config, ... }: {
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      theo = {
        imports = [
          ./home.nix
          inputs.self.outputs.homeManagerModules.default
        ];
      };
    };
  };
}
