# modules/desktop/audio.nix
{ ... }: {
  # This module handles regular pipewire audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
boot.extraModprobeConfig = ''
  options snd_hda_intel power_save=0
'';

}

