{ lib, fetchFromGitHub, buildHomeAssistantComponent, home-assistant, ... }:

buildHomeAssistantComponent rec {
  owner = "make-all";
  domain = "tuya_local";
  version = "2026.4.1";

  src = fetchFromGitHub {
    owner = "make-all";
    repo = "tuya-local";
    tag = "${version}";
    hash = "sha256-tDXl/5CgYsw2x6d6oDjOFlH0M04pznqU6f9PHPkUo9Y=";
    #hash = lib.fakeHash;
  };

  stripRoot = false;

  dependencies = with home-assistant.python.pkgs; [
    tinytuya
    tuya-device-sharing-sdk
  ];

  meta = with lib; {
    changelog = "https://github.com/make-all/tuya-local/archive/refs/tags/${tag}.tar.gz";
    description = "A Home Assistant integration to support devices running Tuya firmware without going via the Tuya cloud. ";
    homepage = "https://github.com/make-all/tuya-local";
    maintainers = with maintainers; [ make-all ];
    license = licenses.mit;
  };
}