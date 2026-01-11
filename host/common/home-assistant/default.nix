{ config, pkgs, lib, ... }:

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

  services.home-assistant = {
    # configWritable = true;
    # lovelaceConfigWritable = true;
    enable = true;
    customComponents = [
      #(pkgs.callPackage ./hacs.nix { })
      (pkgs.callPackage ./versatile-thermostat.nix { })
      #(pkgs.callPackage ./versatile-thermostat-ui-card.nix { })
      (pkgs.callPackage ./vzug.nix { })
      ];
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "homeassistant_hardware"
      #"zha"
      "isal"
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "shopping_list"
      "mqtt"
      "manual_mqtt"
      "mqtt_statestream"
      "mqtt_eventstream"
      "mqtt_json"
      "mqtt_room"
      "brother"
    ];
    config = {
      default_config = {};
      # default_config_exclude = {[
      #   "energy"
      # ]};
      automation = "!include automations.yaml";
      #sensor = "!include sensor.yaml";
      homeassistant = {
        name = "oskar";
        unit_system = "metric";            
        time_zone = "Europe/Zurich";
        country = "CH";
      };
    };
  };
}