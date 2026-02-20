# modules/desktop/bluetooth.nix
{  ... }: {
   services.xserver.enable = true;
   services.displayManager.cosmic-greeter.enable = true;
   services.desktopManager.cosmic.enable = true;
  
  }

