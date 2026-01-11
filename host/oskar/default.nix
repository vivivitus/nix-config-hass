{ pkgs, inputs, ... }: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./networking.nix
    ./storage.nix
    ../common/global
    ../common/home-assistant
    #../common/home-assistant-container
    ../common/user/vivian
  ];

  programs.nix-ld.enable = true;

  nixpkgs.hostPlatform.system = "x86_64-linux";
  system.stateVersion = "25.05";

  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "powersave";

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ ];
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [ "ahci" "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
      kernelModules = [ ];
    };

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
      efi.canTouchEfiVariables = true;
    };
  };
}
