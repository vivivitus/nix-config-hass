{ ... }: {

  imports = [
    ./hardware-configuration.nix
    ./networking
    ../common/global
    ../common/user/vivian
  ];

  system.stateVersion = "24.11";

  #hardware.raspberry-pi."4".apply-overlays-dtmerge.enable = true;

  # New USB driver
  #hardware.raspberry-pi."4".xhci.enable = true;
}
