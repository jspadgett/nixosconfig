# modules/desktop/printing.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.printing;
in
{
  options.jsp.printing.enable =
    lib.mkEnableOption "CUPS printing, with Avahi for network printer discovery";

  config = lib.mkIf cfg.enable {
    services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    environment.systemPackages = [ pkgs.system-config-printer ];
  };
}
