# modules/desktop/xfce.nix
# Lightweight X11 desktop. Host-agnostic — whether/who autologs in is set per-host.
{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.greeters.gtk.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.displayManager.defaultSession = "xfce";

  # Panfrost (Mali T860) first-X init hangs the greeter on the PBP — force software GL.
  environment.sessionVariables.LIBGL_ALWAYS_SOFTWARE = "1";

  # Thunar file manager niceties
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.thunar = {
    enable = true;
    plugins = [pkgs.thunar-archive-plugin pkgs.thunar-volman ];
  };

  environment.systemPackages = with pkgs; [
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    pavucontrol
    networkmanagerapplet
    file-roller
    mousepad
  ];
}
