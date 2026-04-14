{ lib, fetchzip, buildHomeAssistantComponent, home-assistant, pkgs, ... }:

buildHomeAssistantComponent rec {
  owner = "albaintor";
  domain = "electrolux_status";
  version = "2.2.0";

  src = fetchzip {
    url = "https://github.com/albaintor/homeassistant_electrolux_status/archive/refs/tags/v${version}.tar.gz";
    hash = "sha256-Nkn/o7Muheb5ozirvlj+/zYj6B1tA3Y7smSswI1z/+w=";
  };

  dependencies = with home-assistant.python.pkgs; [
    #pyelectroluxocp
    aiofiles
  ];
}
