# /modules/features/networkmanager.nix
{ config, lib, ... }:
let
  cfg = config.jsp.networkmanager;
in
{
  options.jsp.networkmanager.enable = lib.mkEnableOption "NetworkManager";

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}
