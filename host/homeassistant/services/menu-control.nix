{ pkgs, ... }:

let
  pypi-packages = ps: with ps; [

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
    rplcd
    smbus2
    requests
    libgpiod
    scapy
  ];
in
{
  systemd.services.menu-control = {
    enable = true;
    description = "Service that handles the menu logic for a rotary encoder controlled gui";
    unitConfig = {
      After = "multi-user.target";
    };
    serviceConfig = {
      User = "root";
      ExecStart = 
      
        # Complete Python is on unstable branch with this
        let
          python = pkgs.unstable.python3.withPackages (pypi-packages);
        in
      "${python.interpreter} /home/neptune/underwater-communication-software/software/menu-control/menu-control.py --CLK 14 --DT 26 --SW 25";
      
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}