{ inputs, pkgs, lib, config, variables, ... }:
{
  home-manager = {
    extraSpecialArgs = { inherit inputs variables; };
    users = {
      ${variables.userName} = {
        imports = [
          inputs.plasma-manager.homeManagerModules.plasma-manager

          ./home.nix
          inputs.self.outputs.homeManagerModules.default
        ];
      };
    };
  };
}
