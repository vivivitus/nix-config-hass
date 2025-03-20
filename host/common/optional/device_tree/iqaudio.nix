{
    hardware.deviceTree = {
    overlays = [
        {
        name ="iqaudio";
        dtsText = ''
            // Definitions for IQaudIO CODEC
            /dts-v1/;
            /plugin/;

            / {
            compatible = "brcm,bcm2711";

            fragment@0 {
                target = <&i2s>;
                __overlay__ {
                status = "okay";
                };
            };

            fragment@1 {
                target = <&i2c1>;
                __overlay__ {
                #address-cells = <1>;
                #size-cells = <0>;
                status = "okay";

                da2713@1a {
                    #sound-dai-cells = <0>;
                    compatible = "dlg,da7213";
                    reg = <0x1a>;
                    status = "okay";
                };
                };
            };

            fragment@2 {
                target = <&sound>;
                iqaudio_dac: __overlay__ {
                compatible = "iqaudio,iqaudio-codec";
                i2s-controller = <&i2s>;
                status = "okay";
                };
            };

            __overrides__ {
            };
            };
        '';
        }
    ];
    };
}


