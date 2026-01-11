{config, ...}:

{ 
  #networking.firewall.allowedTCPPorts = [ 8123 1883 ];
  networking.firewall.enable = false;

  services.mosquitto = {
    enable = true;
    logType = [ "all" ];
    listeners = [
      {
        acl = [ "pattern readwrite #" ];
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }
    ];
  };

  services.zigbee2mqtt.enable = true; #anscheinend doppelt konfiguriert
  services.zigbee2mqtt.settings = {
    permit_join = true;
    mqtt = {
      server = "mqtt://localhost:1883";
    };
    serial = {
      port = "/dev/ttyACM0";
    };
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers.homeassistant = {
      volumes = [ "home-assistant:/config" ];
      environment.TZ = "Europe/Zurich";
      image = "ghcr.io/home-assistant/home-assistant:stable";
      extraOptions = [ 
        "--network=host"
      ];
    };
  };
}