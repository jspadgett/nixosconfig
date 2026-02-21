# modules/features/intel7-gpu.nix
{ pkgs, ... }: {
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
}
