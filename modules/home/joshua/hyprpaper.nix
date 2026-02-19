# modules/home/joshua/hyprpaper.nix
{ ... }: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/home/joshua/.config/hypr/wallpapers/lockscreen.jpg" ];
      wallpaper = [ "DP-4, /home/joshua/.config/hypr/wallpapers/lockscreen.jpg" ];
    };
  };
 }
