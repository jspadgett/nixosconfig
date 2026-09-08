# modules/desktop/scheduler.nix
{ config, lib, ... }:
let
  cfg = config.jsp.scheduler;
in
{
  options.jsp.scheduler.enable =
    lib.mkEnableOption "the sched_ext scx_lavd scheduler, for gaming latency and frame consistency";

  config = lib.mkIf cfg.enable {
    # Kernel requirement (6.12+) is already satisfied by base.nix
    # (linuxPackages_latest).
    services.scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
  };
}
