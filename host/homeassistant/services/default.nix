{ ... }: {

  imports = [
    ./menu-control.nix
    ./rpc-server.nix
  ];
  
  services.audio-stream = {
    enable = true;
    remotes = "172.16.1.11 172.16.1.12";
    station = true;
  };
}
