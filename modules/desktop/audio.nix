# modules/desktop/audio.nix
{ config, lib, ... }:
let
  cfg = config.jsp.audio;
in
{
  options.jsp.audio.enable = lib.mkEnableOption "PipeWire audio";

  config = lib.mkIf cfg.enable {
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
  };
}
