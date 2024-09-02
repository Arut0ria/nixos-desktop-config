{ system, inputs, config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      ./home-manager.nix
    ];

  # Enabling flakes
  nix.settings.experimental-features = [ "nix-command flakes" ];

  # Boot setup
  boot = {
    # kernelPackages = pkgs.linuxPackages_6_9;
    kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_zen.override rec {
      version = "6.9.12";
      suffix = "lqx2";

      modDirVersion = lib.versions.pad 3 "${version}-${suffix}";
      src = pkgs.fetchFromGitHub {
        owner = "zen-kernel";
        repo = "zen-kernel";
        rev = "v${version}-${suffix}";
        sha256 = "0dpnzy3935svvws0q5w2x09qwkylld663snk44shch8ycdr6i7k9";
      };
    });

    supportedFilesystems = [ "btrfs" "vfat" "ntfs" ];
    initrd.systemd.enable = true;

    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
        useOSProber = true;
      };

      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 10;
    };
  };

  # Intel graphics nothing to do ...
  hardware.opengl = {
    enable = true;
  };

  nvidia-module.enable = lib.mkForce false;
  dlna-module.enable = lib.mkForce false;
  steam-program.enable = lib.mkForce false;
  retroarch-program.enable = lib.mkForce false;
  virtualisation-service.enable = lib.mkForce false;
  mangohud-program.enable = lib.mkForce false;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos-laptop";
  networking.networkmanager.enable = true;

  # Users
  programs.zsh.enable = true;
  users.users.theo = {
    isNormalUser = true;
    extraGroups = lib.mkMerge [
      ([ "wheel" ])
      (lib.mkIf (config.docker-service.enable) [ "docker" ])
      (lib.mkIf (config.virtualisation-service.enable) [ "libvirtd" ])
    ];

    packages = with pkgs; [ ];

    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nixpkgs-fmt
    vlc
    blender
    nh
    p7zip
    htop

    tty-clock
    cava
    deluge

    # vulkan-tools
    # wineWowPackages.stable
    # winetricks
    # wineWowPackages.waylandFull
  ];

  /*
    ZRAM setup
  */
  zramSwap = {
    enable = true;
    memoryPercent = 80;
    # writebackDevice = "/dev/disk/by-partuuid/1e0baea1-a3a8-46d8-aa33-82bbc6e78aaa/zramswap";
  };

  security.polkit.enable = true;

  /*
    Bluetooth setup
  */
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false; # For now...

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}

