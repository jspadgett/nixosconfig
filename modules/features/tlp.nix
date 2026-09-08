# /modules/features/tlp.nix
{ config, lib, ... }:
let
  cfg = config.jsp.tlp;
in
{
  options.jsp.tlp.enable = lib.mkEnableOption "TLP laptop power management";

  config = lib.mkIf cfg.enable {
    # TLP and power-profiles-daemon both claim the same knobs, so the latter
    # has to go off explicitly.
    services.power-profiles-daemon.enable = false;
    services.tlp.enable = true;
  };
}
