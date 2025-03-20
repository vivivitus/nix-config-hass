{ pkgs, config, lib, ... }:

{
  environment.noXlibs = lib.mkForce false;
  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };

  boot.kernel.sysctl."kernel.hostname" = "${config.networking.hostName}.${config.networking.domain}";

  boot.kernel.sysctl."net.ipv4.ip_forward" = "1";
  boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = "1";
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = "1";

  # boot.extraModprobeConfig = ''
  #   options bq27xxx_battery dt_monitored_battery_updates_nvm=0
  # '';

  boot = {
    extraModulePackages = [ config.boot.kernelPackages.rtl88xxau-aircrack ];
    kernelPackages = lib.mkForce pkgs.linuxPackages_rpi4;
    loader = {
      generic-extlinux-compatible.enable = lib.mkDefault true;
      grub.enable = lib.mkDefault false;
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
