# /modules/features/pinepacks.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.pinepacks;
in {
  options.jsp.pinepacks = {
    enable = lib.mkEnableOption "pinepacks — lightweight media + everyday app set for low-power ARM boxes";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # media
      jellyfin-media-player   # hardware-accelerated Jellyfin via mpv
      mpv
      vlc
      # everyday
      ristretto               # image viewer
      evince                  # PDF viewer
      gnome-calculator
      xfce4-screenshooter
    ];
  };
}
