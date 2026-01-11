{ lib, fetchzip, buildHomeAssistantComponent, home-assistant, pkgs, ... }:

let
  python = pkgs.python3.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
      json-repair = pyfinal.callPackage ./vzug-json-repair.nix { };
    };
  };
in
buildHomeAssistantComponent rec {
  owner = "siku2";
  domain = "vzug";
  version = "0.4.5";

  src = fetchzip {
    url = "https://github.com/siku2/hass-vzug/releases/download/${version}/vzug.zip";
    hash = "sha256-vAfiANYzyEHf059hB1JvV3hvCssmFKj3T+gZbEZfWZY=";
  };

  dependencies = [
    (python.withPackages (python-pkgs: [
      python-pkgs.json-repair
    ]))
  ];
}