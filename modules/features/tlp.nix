# /modules/features/tlp.nix
{ ... }: {

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
 }
