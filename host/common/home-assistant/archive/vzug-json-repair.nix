{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
}:

buildPythonPackage rec {
  pname = "json-repair";
  version = "0.46.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "736dda01f64beda240e1500d5f264b969495b05fcb325c7c0eb7ebbfd1210b70";
  };

  doCheck = false;
  #pythonImportsCheck = [ "json-repair" ];

  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}