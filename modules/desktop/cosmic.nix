# modules/desktop/cosmic.nix
{ config, lib, ... }:
let
  cfg = config.jsp.cosmic;
in
{
  options.jsp.cosmic.enable = lib.mkEnableOption "the COSMIC desktop and greeter";

  config = lib.mkIf cfg.enable {
    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true;   # X11 app support (replaces services.xserver.enable)
    };
    services.system76-scheduler.enable = true;
  };
}
