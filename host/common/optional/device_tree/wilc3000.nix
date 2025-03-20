# Wäre so ca das nötige overlay für die anbindung des Wifi moduls über SDIO

{
  hardware.deviceTree = {
  overlays = [
    {
      name ="wilc3000";
      dtsText =''
        /dts-v1/;
        /plugin/;
        / {
          compatible =  "brcm,bcm2711";
          fragment@0 {
            target = <&mmc>;
            wifi_ovl: __overlay__ {
              pinctrl-0 = <&sdio_ovl_pins &wilc_sdio_pins>;
              pinctrl-names =  "default ";
              non-removable;
              bus-width = <4>;
              status =  "okay ";
              #address-cells = <1>;
              #size-cells = <0>;      

              wilc_sdio: wilc_sdio@0 {
                compatible =  "microchip,wilc1000 ",  "microchip,wilc3000 ";
                irq-gpios = <&gpio 6 0>;
                status =  "okay ";
                reg = <0>;
                bus-width = <4>;
              };
            };
          };      

          fragment@1 {
            target = <&gpio>;
            __overlay__ {
              sdio_ovl_pins: sdio_ovl_pins {
                brcm,pins = <22 23 24 25 26 27>;
                brcm,function = <7>; /* ALT3 = SD1 */
                brcm,pull = <0 2 2 2 2 2>;
              };      

              wilc_sdio_pins: wilc_sdio_pins {
                brcm,pins = <6>; /* CHIP-IRQ */
                brcm,function = <0>;
                brcm,pull = <2>;
              };
            };
          };
        };
      '';
      }
    ];
  };
}


