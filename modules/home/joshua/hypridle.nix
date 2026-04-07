# modules/home/joshua/hypridle.nix
{ ... }: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        unlock_cmd = "notify-send \"Unlocked\"";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
      };
      listener = [
        {
          timeout = 870;
          on-timeout = "notify-send \"Idle Warning\" \"Screen locking in 30 seconds\" -u normal -t 25000";
        }
        {
          timeout = 900;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 1800;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && hyprctl dispatch exec \"hyprpaper\"";
        }
      ];
    };
  };
}
