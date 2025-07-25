{ pkgs, lib, config, ... }: {
  imports = [
    ./programs/firefox.nix
    ./programs/zsh.nix
    ./programs/vscode.nix
    ./programs/kitty.nix
    ./programs/fastfetch.nix
    ./programs/plasma-manager.nix
    ./programs/mangohud.nix
    ./programs/ranger.nix
    ./programs/getagal.nix
    ./programs/cava.nix

    ./hyprland/default.nix
  ];

  firefox-program.enable = lib.mkDefault true;
  zsh-program.enable = lib.mkDefault true;
  vscode-program.enable = lib.mkDefault true;
  kitty-program.enable = lib.mkDefault true;
  plasma-manager-config.enable = lib.mkDefault true;
  fastfetch-program.enable = lib.mkDefault true;
  mangohud-program.enable = lib.mkDefault true;
  ranger-program.enable = lib.mkDefault true;
  cava-program.enable = lib.mkDefault true;

  getagal-program.enable = lib.mkDefault true;
}
