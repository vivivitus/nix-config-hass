{ lib, ... }:

{
  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "oskar";
  };
}
