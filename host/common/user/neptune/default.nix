{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # gehört nicht hierher und funktioniert auch nicht. damit müssten user der gruppe gpio zugriff auf gpiochips haben
  users.groups.gpio = {};
  services.udev.extraRules = ''
    SUBSYSTEM=="bcm2835-gpiomem", KERNEL=="gpiomem", GROUP="gpio",MODE="0660"
    SUBSYSTEM=="gpio", KERNEL=="gpiochip*", ACTION=="add", RUN+="${pkgs.bash}/bin/bash -c 'chown root:gpio  /sys/class/gpio/export /sys/class/gpio/unexport ; chmod 220 /sys/class/gpio/export /sys/class/gpio/unexport'"
    SUBSYSTEM=="gpio", KERNEL=="gpio*", ACTION=="add",RUN+="${pkgs.bash}/bin/bash -c 'chown root:gpio /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value ; chmod 660 /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value'"
  '';

  users.users.neptune = {
    isNormalUser = true;
    password = "gaggigaggi";
    extraGroups = [
      "wheel"
      "network"
      "video"
      "audio"
      "gpio"
    ] ++ ifTheyExist [ ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPqON/KlzvnuEAi2DknZm1PL7ypcGAqC7q6Pwr8DJyI vivian@vividesk-2021-12-10"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCVM5mPHUa+G3BdSZCMuPvK7ammaWWaDWpCJpNN23DvNEDoAB24ImJUYe+hM6+uiT05qYY/yAOnPUgvVznmjvOxdy/3C0ovHh9CDtTlsRkFp1h2DuGP1f4ao9UNjNh7OoWEiFOsre2Gb6kfqa1J1cxIG8tMVK16LrohO6/miiT1c1DL9NCEWQqpMrYusDB7zHpfGajMbPUAGWUK8/2xWHP5tHLRiSUBl9HfrBgShRFbGIg/fyBTSBBFASR6zACfHPnvX9q1ScrNdFQd5S/whMkUtTsWptTaGUGGdEFzOAdXWnky1yx5noliZb2XxsJ26geO5TrvVsocLy1vriC0UfgRdHgaDQXu7IwH5EiLc3UpIapAgU6AgxB92Eh7A0GddM9mIuh+hTMpKCXeyqBOjFBSTpK9w3yUXEcIQN/XqQ6T2L56p5xcjxbmNTSuFE1deo62p3trTlSl+25qomLHpqpyvgh2Ts2TdYZsmYdc5uQJfy5kgKKxSUafoQyDQOV1VG70kCZqI8TqmMbtD/u4ErvUMH5FkO4Clt3xWp1NpUl11WDzm1YKcBp9WzotvD9GNhoubghE/2UwPCIjFDQ2TrZHSkFxLOyMBd0xMw0crRV+LKHw0LEBEnw3UpKlnVg6up0Qv89n6LbuaNuOvGREsdWfjcFV8y3TP316qgJ5wddIyQ== vivian@ultravivi"
    ];
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.neptune = import ../../../../home/neptune/${config.networking.hostName}.nix;
}