{
  hardware.deviceTree = {
    overlays = [
      {
        name = "audio-on-overlay";
        dtsText = ''
          /dts-v1/;
          /plugin/;
          / {
            compatible = "brcm,bcm2711";
            fragment@0 {
              target = <&audio>;

              __overlay__ {
                status = "disabled";
              };
            };
          };
        '';
      }
    ];
  };
}