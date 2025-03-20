{ pkgs, config, lib, ... }:

{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
      fsType = "ext4";
    };

  boot.kernel.sysctl."kernel.hostname" = "${config.networking.hostName}.${config.networking.domain}";

  boot.kernel.sysctl."net.ipv4.ip_forward" = "1";
  boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = "1";
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = "1";

  boot = {
    extraModulePackages = [ ];
    kernelPackages = pkgs.linuxPackages_rpi4;
    kernelModules = [ ];
    initrd = {
      availableKernelModules = [ "xhci_pci" ];
      kernelModules = [ ];
    };
    loader = {
      generic-extlinux-compatible.enable = true;
      grub.enable = false;
    };
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  nix.settings = {
    experimental-features = lib.mkDefault "nix-command flakes";
    trusted-users = [ "root" "@wheel" ];
  };
}