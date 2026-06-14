#/modules/desktop/plasma.nix
{ pkgs, ... }: {
# Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
# Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";
# Enable KDE Plasma 6
  services.desktopManager.plasma6.enable = true;

# Phone <-> PC transfers; also auto-opens firewall ports 1714-1764
  programs.kdeconnect.enable = true;

# Bluetooth (bluedevil GUI already ships with plasma6)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

# Helps Android-over-USB (MTP) and GTK-app interop
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.qtsvg
    pavucontrol
    kitty

    # Protocol workers for Dolphin: smb:// sftp:// ftp:// mtp://
    kdePackages.kio-extras
    # Exposes KIO mounts as real paths for non-KDE apps + drag/drop
    kdePackages.kio-fuse
    # Dolphin thumbnails (PDF/SVG + video)
    kdePackages.kdegraphics-thumbnailers
    kdePackages.ffmpegthumbs
  ];

# XDG portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config.plasma.default = [ "kde" ];
  };
}
