# modules/desktop/scheduler.nix
{ ... }: {
  # sched_ext scheduler — gaming latency / frame consistency on aether.
  # Kernel requirement (6.12+) is already satisfied by base.nix (linuxPackages_latest).
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
}
