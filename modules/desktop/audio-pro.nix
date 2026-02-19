{ ... }: {
  imports = [ ./audio.nix ];

  # low latency config for pro audio interface
  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    context.properties = {
      default.clock.rate = 48000;      # UR44 native sample rate
      default.clock.quantum = 128;     # low latency buffer
      default.clock.min-quantum = 64;
      default.clock.max-quantum = 512;
    };
  };
}
