{ pkgs, ... }:

{
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="12d1", ATTRS{idProduct}=="1f01", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch --default-vendor 0x12d1 --default-product 0x1f01 --huawei-new-mode"
  '';
}
