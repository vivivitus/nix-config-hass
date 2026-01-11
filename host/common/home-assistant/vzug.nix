{ lib, fetchzip, buildHomeAssistantComponent, home-assistant, pkgs, ... }:

buildHomeAssistantComponent rec {
  owner = "siku2";
  domain = "vzug";
  version = "0.4.5";

  src = fetchzip {
    url = "https://github.com/siku2/hass-vzug/releases/download/${version}/vzug.zip";
    hash = "sha256-vAfiANYzyEHf059hB1JvV3hvCssmFKj3T+gZbEZfWZY=";
  };
  
  postPatch = ''
    substituteInPlace manifest.json --replace 'json-repair~=0.46.2' 'json-repair>=0.46.2'
  '';

  dependencies = with home-assistant.python.pkgs; [
    json-repair
  ];
}
