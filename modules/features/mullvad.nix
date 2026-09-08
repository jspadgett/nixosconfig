# /modules/features/mullvad.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.mullvad;
in
{
  options.jsp.mullvad.enable = lib.mkEnableOption "Mullvad VPN";

  config = lib.mkIf cfg.enable {
    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs.mullvad-vpn;
    environment.systemPackages = [ pkgs.mullvad-vpn ];
  };
}
