{ inputs, pkgs, lib, config, ... }:
let
  inherit (import ../variables.nix) userName;
in
{
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      ${userName} = {
        imports = [
          inputs.plasma-manager.homeManagerModules.plasma-manager

          ./home.nix
          inputs.self.outputs.homeManagerModules.default
        ];
      };
    };
  };
}
