# modules/desktop/bluetooth.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.bluetooth;
in
{
  options.jsp.bluetooth.enable = lib.mkEnableOption "Bluetooth, with the blueman applet";

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General.Experimental = true;
        Policy.AutoEnable = true;
      };
    };
    environment.systemPackages = [ pkgs.blueman ];
  };
}
