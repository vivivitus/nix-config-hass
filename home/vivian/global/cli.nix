{ pkgs, ... }: {

  programs.bash = {
    enable = true;
    initExtra = "cd $HOME/nix-config-hass";
  };

  home.packages = with pkgs; [
    ncdu
    usbutils
    pciutils
    wget
  ];
}