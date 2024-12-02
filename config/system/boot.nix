{pkgs, lib, ...} : {
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
}
