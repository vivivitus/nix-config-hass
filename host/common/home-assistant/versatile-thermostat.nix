{ lib, fetchzip, buildHomeAssistantComponent, home-assistant, pkgs, ... }:

buildHomeAssistantComponent rec {
  owner = "jmcollin78";
  domain = "versatile_thermostat";
  version = "8.5.1";

  src = fetchzip {
    url = "https://github.com/jmcollin78/versatile_thermostat/archive/refs/tags/${version}.zip";
    hash = "sha256-zSpeiSK8FyXlM1U8jjSVl1nLQX/IplvKHfS6XZUNxo4=";
  };

  dependencies = with home-assistant.python.pkgs; [
    numpy
    scipy
  ];
}
