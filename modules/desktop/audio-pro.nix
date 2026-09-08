# modules/desktop/audio-pro.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.audio-pro;
in
{
  options.jsp.audio-pro.enable =
    lib.mkEnableOption "low-latency PipeWire tuning for the UR44 interface";

  config = lib.mkIf cfg.enable {
    # This used to be `imports = [ ./audio.nix ]`, which made the dependency
    # invisible from the host. Declaring it as an option instead means the
    # host's flag list shows both, and audio.nix is imported like every other
    # module rather than pulled in sideways.
    jsp.audio.enable = true;

    services.pipewire.extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;      # UR44 native sample rate
        default.clock.quantum = 128;     # low latency buffer
        default.clock.min-quantum = 64;
        default.clock.max-quantum = 512;
      };
    };

    # snd_hda_intel power_save=0 lives in audio.nix. It is types.lines, so
    # defining it in both files concatenated rather than conflicted and
    # emitted the option twice.
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0499", ATTR{idProduct}=="1704", ATTR{power/control}="on"
    '';

    environment.systemPackages = [
      pkgs.qpwgraph
      pkgs.jack-example-tools
    ];
  };
}
