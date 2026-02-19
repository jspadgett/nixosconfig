# modules/desktop/bluetooth.nix
{ pkgs, ... }: {

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings.General.Experimental = true;
  hardware.bluetooth.settings.Policy.AutoEnable = true;
  environment.systemPackages = [ pkgs.blueman ];
  }

