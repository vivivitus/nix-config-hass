{ ... }: {

  imports = [
    ./networking.nix
    ./wwan.nix
    ./wireguard.nix
  ];
}