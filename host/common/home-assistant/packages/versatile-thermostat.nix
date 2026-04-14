{ lib, fetchzip, buildHomeAssistantComponent, home-assistant, pkgs, ... }:

buildHomeAssistantComponent rec {
  owner = "jmcollin78";
  domain = "versatile_thermostat";
  version = "9.3.3";

  src = fetchzip {
    url = "https://github.com/jmcollin78/versatile_thermostat/archive/refs/tags/${version}.zip";
    hash = "sha256-TiaJFFx3nEUYHVB5Ka71MaP8pngcPSdHxt920NSCQ8c=";
    #hash = lib.fakeHash;
  };

  dependencies = with home-assistant.python.pkgs; [
    numpy
    scipy
  ];
}
