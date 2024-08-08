{ inputs, ... }: {
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      theo = import ./home.nix;
      modules = [
        ./home.nix
        inputs.self.outputs.homeManagerModules.default
      ];
    };
  };
}
