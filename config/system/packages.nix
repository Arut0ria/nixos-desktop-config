{ pkgs, lib, ... }: {
  packages = lib.mkMerge [
    (with pkgs;
    [
      git
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      nixpkgs-fmt
      vlc
      blender
      nh
      p7zip
      rar
      htop

      tty-clock
      cava
      deluge
      playerctl

      vulkan-tools
      wineWowPackages.stable
      winetricks
      wineWowPackages.waylandFull

      ags
      gimp
      inkscape
      easyeffects
    ])
  ];
}
