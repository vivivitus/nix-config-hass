{
  lib,
  fetchzip,
  buildHomeAssistantComponent,
  home-assistant,
}:
let
  version = "2.0.5";
in
buildHomeAssistantComponent rec {
  owner = "ludeeus";
  domain = "hacs";
  inherit version;

  src = fetchzip {
    url = "https://github.com/hacs/integration/releases/download/${version}/hacs.zip";
    stripRoot = false;
    hash = "sha256-iMomioxH7Iydy+bzJDbZxt6BX31UkCvqhXrxYFQV8Gw=";
  };

  dependencies = with home-assistant.python.pkgs; [
    aiogithubapi
  ];
}