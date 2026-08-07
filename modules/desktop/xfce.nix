# modules/desktop/xfce.nix
# Lightweight X11 desktop for the Pinebook Pro (RK3399, 4GB, Panfrost).
# X11 + LightDM deliberately: sidesteps Wayland/Panfrost compositor quirks
# and stays responsive on weak hardware.
{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  # LightDM is the lightest well-supported greeter.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.displayManager.defaultSession = "xfce";
  services.displayManager.autoLogin = { enable = true; user = "melissa" };
  # Auto-login for a non-technical user. Point this at HER account once you
  # create it — as written it would log into your "joshua" admin account.
  # services.displayManager.autoLogin = { enable = true; user = "mom"; };

  # Thunar file manager niceties: mounting, thumbnails, archives.
  services.gvfs.enable = true;      # USB / MTP / network mounts
  services.tumbler.enable = true;   # thumbnails
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };

  environment.systemPackages = with pkgs; [
    xfce.xfce4-whiskermenu-plugin   # searchable app menu (friendlier than the default)
    xfce.xfce4-pulseaudio-plugin    # volume control in the panel
    pavucontrol                     # audio GUI (needs audio.nix for the pipewire backend)
    networkmanagerapplet            # wifi applet in the panel
    file-roller                     # archive GUI
    mousepad                        # simple text editor
  ];
}
