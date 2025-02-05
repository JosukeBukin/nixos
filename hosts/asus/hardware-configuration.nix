# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7b965ed6-a751-4795-905d-02ff82f47e6a";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EA9F-097F";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/00e0465e-f8e2-4cc0-a628-73df54b265f8";
      fsType = "ext4";
    };
  fileSystems."/diskette" =
    { device = "/dev/disk/by-uuid/e8696cd4-fcb7-40da-81ff-3aaa2a4b9a72";
      fsType = "btrfs";
    };
  fileSystems."/nix" =
    { depends = [
	"/diskette"
      ];
      device = "/diskette/nix";
      fsType = "none";
      options = [
	"bind"
	"rw"
      ];
    };
  fileSystems."/home/ilia/Загрузки" =
    { depends = [
	"/home"
	"/diskette"
      ];
      device = "/diskette/Загрузки";
      fsType = "none";
      options = [
	"bind"
	"rw"
      ];
    };
  fileSystems."/home/ilia/Документы" =
    { depends = [
	"/home"
	"/diskette"
      ];
      device = "/diskette/Документы";
      fsType = "none";
      options = [
	"bind"
	"rw"
      ];
    };
  fileSystems."/home/ilia/Видео" =
    { depends = [
	"/home"
	"/diskette"
      ];
      device = "/diskette/Видео";
      fsType = "none";
      options = [
	"bind"
	"rw"
      ];
    };
  fileSystems."/home/ilia/Игры" =
    { depends = [
	"/home"
	"/diskette"
      ];
      device = "/diskette/Игры";
      fsType = "none";
      options = [
	"bind"
	"rw"
      ];
    };
  fileSystems."/home/ilia/Изображения" =
    { depends = [
	"/home"
	"/diskette"
      ];
      device = "/diskette/Изображения";
      fsType = "none";
      options = [
	"bind"
	"rw"
      ];
    };
  fileSystems."/home/ilia/Музыка" =
    { depends = [
	"/home"
	"/diskette"
      ];
      device = "/diskette/Музыка";
      fsType = "none";
      options = [
	"bind"
	"rw"
      ];
    };
  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  
  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
	offload = {
	   enable = true;
	   enableOffloadCmd = true;
  	};
	intelBusId = "PCI:0:2:0";
	nvidiaBusId = "PCI:1:0:0";
    };
  };
}
