{ lib, fetchzip, buildHomeAssistantComponent, home-assistant, ... }:

buildHomeAssistantComponent rec {
  owner = "FezVrasta";
  domain = "cafe";
  version = "0.6.0";

  src = fetchzip {
    url = "https://github.com/FezVrasta/cafe-hass/releases/download/v${version}/cafe.zip";
    hash = "sha256-rFw9sjN9IjQ+ml7sq5W7K1irWswY5FP7nVC0GsXVuhg=";
    #hash = lib.fakeHash;
    stripRoot = false;
  };

  meta = with lib; {
    changelog = "https://github.com/FezVrasta/cafe-hass/archive/refs/tags/${tag}.tar.gz";
    description = "C.A.F.E. is a visual flow editor that brings Node-RED-style power to Home Assistant without the external engine.";
    homepage = "https://github.com/FezVrasta/cafe-hass";
    maintainers = with maintainers; [ FezVrasta ];
    license = licenses.mit;
  };
}