{
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.0.10.101/32" ];
      privateKeyFile = "/home/neptune/underwater-communication-nix-config/host/station/networking/wg_secrets/key.private";
      listenPort = 51820;
      mtu = 1280;      
      peers = [
        {
          publicKey = "3A+sORsTbOiCfTkJ7Jl5yZ06xJI7d8UXmeHbjZHIjhM=";
          allowedIPs = [ "10.0.10.0/24" "10.0.11.0/24" "10.0.2.0/24" ];
          endpoint = "vpn.vivi.land:51820";
          persistentKeepalive = 25;
          dynamicEndpointRefreshSeconds = 5;
          dynamicEndpointRefreshRestartSeconds = 20;
        }
      ];
    };
  };
}