# /modules/features/tailscale.nix
{ config, lib, ... }:
let
  cfg = config.jsp.tailscale;
in
{
  options.jsp.tailscale.enable = lib.mkEnableOption "Tailscale mesh VPN";

  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;
  };
}
