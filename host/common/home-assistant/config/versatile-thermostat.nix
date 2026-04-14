{ config, pkgs, lib, ... }:

{
    services.home-assistant.config = {
        versatile_thermostat = {
            external_sensor_id = "sensor.environment_temperature_outdoor";

            power_management_activated = false;
            energy_management_activated = false;

            tpi_coef_int = 0.6; # Indoor coefficient (adjust based on insulation)
            tpi_coef_ext = 0.01; # Outdoor coefficient
            
            eco_temp = 18.0;
            comfort_temp = 21.0;
            boost_temp = 22.0;
            frost_temp = 15.0;
        };

        # climate = [
        #     {
        #     platform = "versatile_thermostat";
        #     name = "Main Room";
        #     unique_id = "vtherm_main_room";
        #     # Links this entity to the central config above
        #     central_configuration_id = "central_configuration"; 
            
        #     # Local sensors
        #     temp_sensor = "sensor.your_indoor_temp_sensor"; 
        #     # You can override TPI or Presets here if needed, 
        #     # otherwise they inherit from the central config.
        #     }
        # ];
    };
}