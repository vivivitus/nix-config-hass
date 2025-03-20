{ pkgs, ... }:

let
  pypi-packages = ps: with ps; [
    # ...
    (
      buildPythonPackage rec {
        pname = "pyalsaaudio";
        version = "0.10.0";
        src = fetchPypi {
          inherit pname version;
          sha256 = "e21175500a2bd310ae3867e7991639defc1e2a5c92cf1b9f7083296b346738ab";
        };
        doCheck = false;
        propagatedBuildInputs = [
          pkgs.alsa-lib.dev
        ];
      }
    )

    (
      buildPythonPackage rec {
        pname = "tinyrpc";
        version = "1.1.7";
        src = fetchPypi {
          inherit pname version;
          sha256 = "15a8f41838e7b8be274467de59ad5c571e4cb5a2fe93bc2940b1d103bce4c6e5";
        };
        doCheck = false;
      }
    )

    # Additional python packages from nixpkgs
    gevent
    werkzeug
    rplcd
    smbus2
    requests
    libgpiod
  ];

in
{
  environment.systemPackages = [
    (pkgs.unstable.python3.withPackages pypi-packages)
  ];
}
