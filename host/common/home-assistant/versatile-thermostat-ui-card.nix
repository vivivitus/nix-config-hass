{ lib, fetchzip, buildHomeAssistantComponent, home-assistant, pkgs, ... }:

buildHomeAssistantComponent rec {
  owner = "jmcollin78";
  domain = "versatile-thermostat-ui-card";
  version = "2.1.2";

  src = fetchzip {
    url = "https://github.com/jmcollin78/versatile-thermostat-ui-card/archive/refs/tags/${version}.zip";
    hash = "sha256-YhUDbLWx9drh4Fiz7ku7/Wdix9W5ozV8/DJQsVbnTQw=";
  };
}
