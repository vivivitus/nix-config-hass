{ ... }: {

  imports = [
    ./networking
    ./services
    ./sound
    ../common/global
    ../common/services
    ../common/user/neptune

    # Hardware imports
    ./hardware-configuration.nix
    ../common/optional/device_tree/iqaudio.nix
    ../common/optional/device_tree/i2c.nix
    #../common/optional/device_tree/bq27441-g1a.nix
  ];

  system.stateVersion = "23.05";

  hardware.raspberry-pi."4".apply-overlays-dtmerge.enable = true;
  # hardware.raspberry-pi."4".i2c0.enable = true;
  # hardware.raspberry-pi."4".i2c1.enable = true;
  hardware.i2c.enable=true;

  # New USB driver
  hardware.raspberry-pi."4".xhci.enable = true;

  hardware.deviceTree = {
    enable = true;
    filter = "*cm4.dtb";
  };
}
