# dtparam gibts nicht mehr bei NixOS drum müsste alles mit overlays gelöst werden.
# gewisse dinge sind aber schwer lösbar, wie beispielsweise i2c bus 0 auf gpio 0-1.

{
  hardware.deviceTree = {
  overlays = [

    {
      name ="i2c0-bq";
      dtsText =''
        /dts-v1/;
        /plugin/;

        / {
          compatible = "brcm,bcm2711";

          fragment@0 {
            target = <&i2c0>;
            __overlay__ {
              status = "okay";
              #address-cells = <1>;
              #size-cells = <0>; 
              bat: battery {
                compatible = "simple-battery";
                voltage-min-design-microvolt = <3200000>;
                energy-full-design-microwatt-hours = <17760000>;
                charge-full-design-microamp-hours = <4800000>;
              };

              bq27441: fuel-gauge@55 {
                compatible = "ti,bq27441";
                reg = <0x55>;
                monitored-battery = <&bat>;
              };
            };    
          };
        };
      '';
      }
    ];
  };
}