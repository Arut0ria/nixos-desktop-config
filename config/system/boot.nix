{ pkgs, lib, ... }: {
  # Boot setup
  boot = {
    # kernelPackages = pkgs.linuxPackages_6_9;
    kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_zen.override {
      argsOverride = rec {
        version = "6.13.7";
        suffix = "lqx1";

        modDirVersion = lib.versions.pad 3 "${version}-${suffix}";
        src = pkgs.fetchFromGitHub {
          owner = "zen-kernel";
          repo = "zen-kernel";
          rev = "v${version}-${suffix}";
          sha256 = "sha256-TAp068FBRsRZwheCEU9nDUhNGk3yXxDjThy3FQd0Mn4=";
        };
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
}
