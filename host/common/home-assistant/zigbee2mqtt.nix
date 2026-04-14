{ config, pkgs, ... }:

{

  networking.firewall.allowedTCPPorts = [ 8080 1883 ];

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

  services.zigbee2mqtt = {
    enable = true;
    package = pkgs.zigbee2mqtt_2;
    settings = {
      homeassistant.enabled = config.services.home-assistant.enable;
      mqtt.server = "mqtt://localhost:1883";
      serial = {
        port = "/dev/serial/by-id/usb-ITEAD_SONOFF_Zigbee_3.0_USB_Dongle_Plus_V2_20230807090832-if00";
        adapter = "ember";
      };
      frontend.enabled = true;
    };
  };
}