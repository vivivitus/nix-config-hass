{
  hardware.deviceTree = {
    overlays = [
      {
        name = "i2c0-overlay";
        dtsFile = ./i2c0.dts;
      }

      {
        name = "i2c1-overlay";
        dtsFile = ./i2c1.dts;
      }

      {
        name = "bq27441-g1a";
        dtsFile = ./bq27441-g1a.dts;
      }
    ];
  };
}