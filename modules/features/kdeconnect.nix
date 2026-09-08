# /modules/features/kdeconnect.nix
{ config, lib, ... }:
let
  cfg = config.jsp.kdeconnect;
in
{
  # Built but not enabled on any host. Previously a commented-out import,
  # which meant the module could drift without ever being evaluated; now it
  # is evaluated everywhere and simply gated off.
  options.jsp.kdeconnect.enable =
    lib.mkEnableOption "KDE Connect, including the firewall rules it needs";

  config = lib.mkIf cfg.enable {
    programs.kdeconnect.enable = true;
  };
}
