{ config, lib, ... }: {
  services.hyprpaper.enable = true;

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/joshua/.config/hypr/wallpapers/lockscreen.jpg

    wallpaper {
      monitor =
      path = /home/joshua/.config/hypr/wallpapers/lockscreen.jpg
    }
  '';
}
