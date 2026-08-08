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
