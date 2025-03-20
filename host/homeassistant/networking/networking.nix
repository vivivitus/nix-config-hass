{pkgs, config, ...}:

{

  systemd.network.links."10-wwan" = {
    matchConfig.PermanentMACAddress = "00:1e:10:1f:00:00";
    linkConfig.Name = "wwan";
  };

  systemd.network.links."20-wlan" = {
    matchConfig.PermanentMACAddress = "00:e0:4c:49:05:33";
    linkConfig.Name = "wlan";
  };

  systemd.network.links."30-eth" = {
    matchConfig.PermanentMACAddress = "e4:5f:01:ea:b9:b7";
    linkConfig.Name = "ethernet";
  };

  systemd.network.links."40-eth" = {
    matchConfig.PermanentMACAddress = "9c:eb:e8:12:bc:de";
    linkConfig.Name = "ethernet_temp";
  };

  networking = {
    networkmanager.enable = true;
    networkmanager.unmanaged = ["wlan"];

    hostName = "station";
    domain = "local";
    firewall.enable = false;
    resolvconf.dnsExtensionMechanism = false;
    wireless.enable = true;
    usePredictableInterfaceNames = false;
    interfaces.wlan.ipv4.addresses = [
      {
        address = "172.16.1.1";
        prefixLength = 24;
      }
    ];
  };

  # <hostname>.local resolution
  services.resolved = {
    enable = true;
    dnssec = "false";
    extraConfig = "DNSOverTLS=no";
  };



      # hw_mode=b
      # preamble=1
      # supported_rates=10 20 55 110
      # basic_rates=10 20 55 110

  # Access Point configuration
  services.hostapd = {
    enable = true;
    extraConfig = ''
      ieee80211n=1
      wmm_enabled=1
      # ht_capab=[HT40+][SHORT-GI-20][SHORT-GI-40][SMPS-STATIC][DSSS_CCK-40][MAX-AMSDU-7935]
    '';
    interface = "wlan";
    ssid = "station";
    wpaPassphrase = "gaggigaggi";
    countryCode = "CH";
  };

  #networking.firewall.allowedUDPPorts = lib.optionals config.services.hostapd.enable [53 67]; # DNS & DHCP

  # Solves potentially slow connection
  services.haveged.enable = config.services.hostapd.enable;

  services.dnsmasq = {
    enable = true;
    settings = {
      server =
      [
        "8.8.8.8"
        "8.8.4.4"
        "2001:4860:4860::8888"
        "2001:4860:4860::8844"
      ];
      interface = "wlan";
      bind-interfaces = true;
      domain-needed = true;
      dhcp-range = [ "172.16.1.100,172.16.1.254" ];
      address= "/station.local/172.16.1.1";
    };
  };

  systemd.services.wifi-relay = let inherit (pkgs) iptables;
  in {
    description = "iptables rules for wifi-relay";
    after = [ "dnsmasq.service" ];
    wantedBy = [ "multi-user.target" ];
    script = ''
    ${iptables}/bin/iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    ${iptables}/bin/iptables -t nat -A POSTROUTING -o wwan -j MASQUERADE
    ${iptables}/bin/iptables -A FORWARD -i wlan -o wwan -j ACCEPT
    ${iptables}/bin/iptables -t nat -A POSTROUTING -o ethernet -j MASQUERADE
    ${iptables}/bin/iptables -A FORWARD -i wlan -o ethernet -j ACCEPT
    ${iptables}/bin/iptables -t nat -A POSTROUTING -o ethernet_temp -j MASQUERADE
    ${iptables}/bin/iptables -A FORWARD -i wlan -o ethernet_temp -j ACCEPT
    '';
  };
}