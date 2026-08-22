# modules/desktop/xfce.nix
{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.displayManager.defaultSession = "xfce";

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.thunar = {
    enable = true;
    plugins = [ pkgs.thunar-archive-plugin pkgs.thunar-volman ];
  };

  environment.systemPackages = with pkgs; [
    xfce4-whiskermenu-plugin xfce4-pulseaudio-plugin
    pavucontrol networkmanagerapplet file-roller mousepad
  ];
}
