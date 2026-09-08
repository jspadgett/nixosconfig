# modules/desktop/plasma.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.plasma;
in
{
  # Built but not enabled on any host — aether moved to Hyprland, and
  # desktop/hyprland.nix took over the SDDM setup this module used to provide.
  options.jsp.plasma.enable = lib.mkEnableOption "the KDE Plasma 6 desktop";

  config = lib.mkIf cfg.enable {
    # X11 windowing system — kept for the optional Plasma X11 session (not
    # needed by Wayland itself)
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    # Keyboard layout (kwin reads this on Wayland too)
    services.xserver.xkb.layout = "us";

    services.desktopManager.plasma6.enable = true;

    # Phone <-> PC transfers. Routed through the shared toggle rather than
    # setting programs.kdeconnect directly, so there is one place that owns it.
    jsp.kdeconnect.enable = true;

    # bluedevil (BT GUI) ships with plasma6; the Bluetooth daemon + Lily58
    # tuning live in bluetooth.nix.
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

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
      config.kde.default = [ "kde" ];
    };
  };
}
