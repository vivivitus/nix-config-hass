{ ... }: {

  imports = [  ];

  services = {
    battery-capacity-fix.enable = true;
    alsa-config-store.enable = true;
    alsa-config-restore.enable = true;
    openssh = {
      enable = true;
      banner = "He sali zemme! I bis, euen geliebte Raspi! \n";
    };
  };
}
