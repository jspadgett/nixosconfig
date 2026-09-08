# /modules/features/flatpak.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.flatpak;
in
{
  options.jsp.flatpak.enable = lib.mkEnableOption "Flatpak";

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;

    # athena has no hyprland.nix, so it needs the GTK portal declared here.
    # On hosts that do run Hyprland this merges with the portal set nixpkgs'
    # wayland-session.nix already provides.
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
