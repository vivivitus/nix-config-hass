{ lib, fetchzip, buildHomeAssistantComponent, home-assistant, pkgs, ... }:

buildHomeAssistantComponent rec {
  owner = "jmcollin78";
  domain = "versatile_thermostat";
  version = "8.2.0";

  src = fetchzip {
    url = "https://github.com/jmcollin78/versatile_thermostat/archive/refs/tags/${version}.zip";
    hash = "sha256-/5oHUnCnnw320kDhUIaqqHSzR54EUPnfixViAzTQeV0=";
  };
}
