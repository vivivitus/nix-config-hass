{ lib, python3Packages, fetchFromGitHub }:

python3Packages.buildPythonApplication {
  pname = "open3e";
  version = "main"; # Or a specific tag/commit

  src = fetchFromGitHub {
    owner = "open3e";
    repo = "open3e";
    rev = "master"; # Use a specific hash for reproducibility
    hash = lib.fakeHash;
  };

  propagatedBuildInputs = with python3Packages; [
    canopen
    python-can
    paho-mqtt
    # Add other dependencies listed in open3e's setup.py/requirements.txt
  ];

  doCheck = false; # Skip tests if they require hardware access

  meta = with lib; {
    description = "Read and write data from Viessmann E3 devices via CAN";
    homepage = "https://github.com/open3e/open3e";
    license = licenses.mit;
  };
}