{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.open3e
    pkgs.can-utils
  ];
  
  # Ensure CAN-bus utilities are available
  boot.kernelModules = [ "can" "can-raw" "vcan" "slcan" ];
}