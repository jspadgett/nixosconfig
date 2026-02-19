#/modules/desktop/hyprland.nix
{ pkgs, ... }: {
#
#
# installs hyprland and hyprland programs
# Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
# Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";
# Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };
   environment.systemPackages = with pkgs; [
    waybar
    dunst
    hyprpaper
    libnotify
    wofi
    hyprshot
    hyprlock
    swww
    wallust
    hypridle
    kitty
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    kdePackages.qtsvg
    pavucontrol
    pywal
    ];
 # XDG portals — critical for screenshare, file picker
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.hyprland.default = [ "hyprland" "gtk" ];
  };
 }

