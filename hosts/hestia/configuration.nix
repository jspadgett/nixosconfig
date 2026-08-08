# /hosts/hestia/configuration.nix
{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];  # generated on first install (step 5)

  # Tow-Boot in SPI presents UEFI, so systemd-boot works like your other hosts.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;  # RK3399 EFI vars aren't persistent

  networking.hostName = "hestia";
  hardware.acpilight.enable = true;  # working backlight control on PBP
  services.displayManager.autoLogin = { enable = true; user = "melissa"; };
  # Reaches the greeter and the X server, not just the user session
  environment.variables.LIBGL_ALWAYS_SOFTWARE = "1";

  # Put the same var into LightDM's own environment
  services.xserver.displayManager.lightdm.extraSeatDefaults = ''
    greeter-setup-script=/bin/sh -c "export LIBGL_ALWAYS_SOFTWARE=1"
  '';
  users.users.joshua = {
    isNormalUser = true;
    description = "joshua";
    extraGroups = [ "networkmanager" "wheel" "video" "render" ];
  };
   # Mom's account — fill in the username, then flip on autologin in xfce.nix.
  users.users.melissa = {
    isNormalUser = true;
    description = "melissa";
    extraGroups = [ "networkmanager" "video" ];  # deliberately NO wheel = no sudo
    initialPassword = "changeme";
  };
  system.stateVersion = "26.05";
}
