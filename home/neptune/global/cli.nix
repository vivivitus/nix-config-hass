{ pkgs, ... }: {

  programs.bash = {
    enable = true;
    initExtra = "cd $HOME/underwater-communication-nix-config";
  };

  home.packages = with pkgs; [
    nil
    ncdu
    tree
    usbutils
    pciutils
    i2c-tools
    dtc
    libgpiod
    wget
  ];
}