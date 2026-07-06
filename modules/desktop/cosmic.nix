# modules/desktop/cosmic.nix
{ ... }: {
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;   # X11 app support (replaces services.xserver.enable)
  };
  services.system76-scheduler.enable = true;
}
