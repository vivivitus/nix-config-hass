{ ... }: {

  # enable ALSA sound and import configuration for /etc/asound.conf
  sound.enable = true;
  imports = [ ./alsa_config.nix ];
}
