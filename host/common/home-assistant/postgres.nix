{ config, pkgs, ... }:

{
  # services.home-assistant = {
  #   extraPackages = ps: with ps; [ psycopg2 ];
  #   config.recorder.db_url = "postgresql://homeassistant@/homeassistant";
  # };

  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all      all     trust
    '';
    ensureDatabases = [ "homeassistant" ];
    ensureUsers = [
      {
        name = "homeassistant";
        ensureDBOwnership = true;
      }
    ];
  };
}
