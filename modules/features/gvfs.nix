# /modules/features/gvfs.nix
{ config, lib, ... }:
let
  cfg = config.jsp.gvfs;
in
{
  # GVFS provides virtual filesystem support: trash, remote mounts, and MTP
  # for Android devices over USB. Hosts running desktop/hyprland.nix already
  # get gvfs from there and should leave this off.
  options.jsp.gvfs.enable = lib.mkEnableOption "GVFS, including MTP support for Android devices";

  config = lib.mkIf cfg.enable {
    services.gvfs.enable = true;
  };
}
