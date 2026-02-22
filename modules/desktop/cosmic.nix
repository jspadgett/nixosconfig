# modules/desktop/bluetooth.nix
{  ... }: {
   services.xserver.enable = true;
   services.displayManager.cosmic-greeter.enable = true;
   services.desktopManager.cosmic.enable = true;
   services.system76-scheduler.enable = true;  

   environment.systemPackages = with pkgs; [
     ffmpeg-headless # video decoding for thumbnails
     ffmpegthumbnailer
   ];
  }

