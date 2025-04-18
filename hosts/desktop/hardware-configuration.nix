# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ system ? "x86_64-linux", config, lib, pkgs, modulesPath, ... }@inputs:
let
  extraOptions = [
    "compress=zstd"
    "discard=async"
    "noatime"
  ];
in
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "nvidia-drm.fbdev=1"
    # "NVreg_EnableGpuFirmware=0"
  ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/47f2d645-952c-4060-a1c6-0dc528fea7f8";
      fsType = "btrfs";
      options = [ "subvol=root" ] ++ extraOptions;
    };

  boot.initrd.luks.devices = {
    crypted-root = {
      device = "/dev/disk/by-uuid/8917ae7a-b130-4314-94a6-dd3cf1032e6f";
      preLVM = true;
    };
  };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/47f2d645-952c-4060-a1c6-0dc528fea7f8";
      fsType = "btrfs";
      options = [ "subvol=home" ] ++ extraOptions;
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/47f2d645-952c-4060-a1c6-0dc528fea7f8";
      fsType = "btrfs";
      options = [ "subvol=nix" ] ++ extraOptions;
    };

  fileSystems."/persist" =
    {
      device = "/dev/disk/by-uuid/47f2d645-952c-4060-a1c6-0dc528fea7f8";
      fsType = "btrfs";
      options = [ "subvol=persist" ] ++ extraOptions;
    };

  fileSystems."/var/log" =
    {
      device = "/dev/disk/by-uuid/47f2d645-952c-4060-a1c6-0dc528fea7f8";
      fsType = "btrfs";
      options = [ "subvol=log" ] ++ extraOptions;
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/E43B-B7AD";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  /*
    Shared disk definitions (dual boot)
  */
  fileSystems."/media/Data1" = {
    device = "/dev/disk/by-label/Data1";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ];
  };

  fileSystems."/media/Data2" = {
    device = "/dev/disk/by-label/Data2";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ];
  };

  fileSystems."/media/Data3" = {
    device = "/dev/disk/by-label/Data3";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ];
  };

  swapDevices = lib.mkForce [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp42s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.hostPlatform = lib.mkDefault system;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableAllFirmware = false;
  hardware.enableRedistributableFirmware = true;
}
