#/modules/desktop/plasma.nix
{ pkgs, ... }: {
# X11 windowing system — kept for the optional Plasma X11 session (not needed by Wayland itself)
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
# Keyboard layout (kwin reads this on Wayland too)
  services.xserver.xkb.layout = "us";
# Enable KDE Plasma 6
  services.desktopManager.plasma6.enable = true;
# Phone <-> PC transfers; auto-opens firewall ports 1714-1764
  programs.kdeconnect.enable = true;
# bluedevil (BT GUI) ships with plasma6; the Bluetooth daemon + Lily58 tuning live in bluetooth.nix
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
    config.kde.default = [ "kde" ];
  };
}
