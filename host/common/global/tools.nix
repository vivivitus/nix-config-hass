{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable.libgpiod
    libusb
    usb-modeswitch
  ];
}