{ inputs, pkgs, lib, config, variables, ... }@args:
{
  home-manager = {
    extraSpecialArgs = {
      inherit inputs variables;
      system = args.system;
    };

    users = {
      ${variables.userName} = {
        imports = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          inputs.getagal.homeManagerModules.getagal

          ./home.nix
          inputs.self.outputs.homeManagerModules.default
        ];
      };
    };
  };
}
