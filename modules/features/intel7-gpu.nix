# /modules/features/intel7-gpu.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.intel7-gpu;
in
{
  options.jsp.intel7-gpu.enable =
    lib.mkEnableOption "Intel integrated graphics with VA-API acceleration";

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver   # VA-API (Broadwell and newer)
        intel-vaapi-driver   # better for Firefox/Chromium
      ];
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };
}
