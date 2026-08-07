# modules/desktop/hyprland.nix — standalone Hyprland desktop (no longer depends on plasma.nix)
{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;          # also enables xdg.portal + adds the version-synced hyprland portal
    withUWSM = true;
    xwayland.enable = true;
  };

  # SDDM used to come from plasma.nix; that module was removed, so provide login here.
  # aether's autologin (services.displayManager.autoLogin in hosts/aether) attaches to this DM.
 services.gvfs.enable = true;   # trash, mounting, remote filesystems
 services.tumbler.enable = true; # thumbnails (alternative to adding the package directly) 
 services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar 
    dunst 
    hyprpaper 
    libnotify 
    wofi 
    hyprshot
    hyprlock 
    wallust 
    hypridle
    kdePackages.kate
    xfce.thunar
    xfce.thunar-volman
    xfce.tumbler
    xfce.thunar-archive-plugin
  ];

  # programs.hyprland already sets xdg.portal.enable and adds the hyprland portal
  # (synced to your Hyprland package). We only add GTK, for the file picker XDPH lacks.
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.hyprland.default = [ "hyprland" "gtk" ];
}
