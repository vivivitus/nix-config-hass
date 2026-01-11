{ lib, fetchzip, buildHomeAssistantComponent, home-assistant, pkgs, ... }:

let
  version = "1.2.0";
in
buildHomeAssistantComponent rec {
  owner = "arturpragacz ";
  domain = "hass-cc-default-config-exclude";
  inherit version;

  src = fetchzip {
    url = "https://github.com/arturpragacz/hass-cc-default-config-exclude/archive/refs/tags/${version}.zip";
    #stripRoot = true;
    hash = "sha256-NolmspEItieGBRqrR9CJpt7nlD3O09yJB9ao1P3OImg=";
  };
}