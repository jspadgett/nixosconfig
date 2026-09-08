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
    hypridle
    kdePackages.kate
    # tumbler comes from services.tumbler.enable above, which registers the
    # D-Bus service as well as installing the package — listing the package
    # here too was redundant, and the package alone would not have worked.
    thunar
    thunar-volman
    thunar-archive-plugin
  ];

  # programs.hyprland sets xdg.portal.enable and, via nixpkgs'
  # wayland-session.nix (enableGtkPortal, default true), already adds BOTH the
  # version-synced hyprland portal and xdg-desktop-portal-gtk. Adding GTK here
  # as well was a third registration of the same portal.
  #
  # This line is still doing real work: it sets the portal *preference order*
  # for the Hyprland session, so XDPH is tried first and GTK is the fallback
  # for the file picker XDPH lacks.
  xdg.portal.config.hyprland.default = [ "hyprland" "gtk" ];
}
