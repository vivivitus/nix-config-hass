{ lib, fetchFromGitHub, buildHomeAssistantComponent, home-assistant, ... }:

buildHomeAssistantComponent rec {
  owner = "siku2";
  domain = "vzug";
  version = "0.4.6";

  src = fetchFromGitHub {
    owner = "siku2";
    repo = "hass-vzug";
    tag = "v${version}";
    hash = "sha256-CxXl3d0b6YSV/24z4jpsA8MAU4U69wnb9UTuQMWkU/s=";
  };

  stripRoot = false;

  postPatch = ''
    substituteInPlace custom_components/vzug/manifest.json --replace 'json-repair~=0.46.2' 'json-repair>=0.46.2'
  '';

  dependencies = with home-assistant.python.pkgs; [
    json-repair
  ];

  meta = with lib; {
    changelog = "https://github.com/siku2/hass-vzug/archive/refs/tags/${tag}.tar.gz";
    description = "Home-Assistant integration for V-ZUG devices.";
    homepage = "https://github.com/siku2/hass-vzug";
    maintainers = with maintainers; [ siku2 ];
    license = licenses.mit;
  };
}