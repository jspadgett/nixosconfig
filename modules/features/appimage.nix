# modules/features/appimage.nix
{ config, lib, ... }:
let
  cfg = config.jsp.appimage;
in
{
  options.jsp.appimage.enable =
    lib.mkEnableOption "running AppImages directly, without manual extraction";

  config = lib.mkIf cfg.enable {
    programs.appimage.enable = true;
  };
}
