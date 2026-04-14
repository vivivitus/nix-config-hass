{ config, pkgs, lib, ... }:

{
  imports = [
   # ./postgres.nix
    ./zigbee2mqtt.nix
   # ./open3e.nix
   # ./config/versatile-thermostat.nix
  ];

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 8123 ];

  services.home-assistant = {
    enable = true;

    customLovelaceModules = [
      pkgs.home-assistant-custom-lovelace-modules.weather-chart-card
    ];

    customComponents = [
      pkgs.home-assistant-custom-components.moonraker
      (pkgs.callPackage ./packages/versatile-thermostat.nix { })
      (pkgs.callPackage ./packages/vzug.nix { })
      (pkgs.callPackage ./packages/cafe.nix { })
      (pkgs.callPackage ./packages/tuya-local.nix { })
    ];

    extraComponents = [
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
      "met"
      "caldav"
    ];

    config = {

      automation = "!include automations.yaml";
      
      homeassistant = {
        name = "oskar";
        unit_system = "metric";            
        time_zone = "Europe/Zurich";
        country = "CH";
        latitude = 47.354336;
        longitude = 8.724723;
        elevation = 487;
        language = "de";
      };

      assist_pipeline = {};
      backup = {};
      bluetooth = {};
      config = {};
      conversation = {};
      dhcp = {};
      #energy = {};
      #go2rtc = {};
      history = {};
      homeassistant_alerts = {};
      #cloud = {};
      image_upload = {};
      logbook = {};
      #media_source = {};
      mobile_app = {};
      my = {};
      ssdp = {};
      stream = {};
      sun = {};
      usage_prediction = {};
      usb = {};
      webhook = {};
      zeroconf = {};
    };
  };
}