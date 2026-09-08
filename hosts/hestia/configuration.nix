# /hosts/hestia/configuration.nix
{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  # Tow-Boot in SPI presents UEFI, so systemd-boot works like the other hosts.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;  # RK3399 EFI vars aren't persistent

  networking.hostName = "hestia";
  hardware.acpilight.enable = true;  # working backlight control on PBP

  services.displayManager.autoLogin = { enable = true; user = "melissa"; };

  jsp.pinepacks.enable = true;
  # Pinebook Pro enablement (audio unmute + hardware video decode)
  pinebook-pro.audio = {
    enable = true;
    users = [ "melissa" "joshua" ];
  };
  pinebook-pro.video.enable = true;
  pinebook-pro.chromium-accel.enable = true;
  environment.systemPackages = with pkgs; [
    xfce4-pulseaudio-plugin
  ];

  users.mutableUsers = false;

  users.users.joshua = {
    isNormalUser = true;
    description = "joshua";
    extraGroups = [ "networkmanager" "wheel" "video" "render" ];
  };

  users.users.melissa = {
    isNormalUser = true;
    description = "melissa";
    extraGroups = [ "networkmanager" "video" ];  # deliberately NO wheel = no sudo
    # hashedPasswordFile comes from features/melissa-password.nix (agenix).
    # Never inline the hash here: mutableUsers = false bakes it into the
    # derivation, which puts it in the world-readable /nix/store.
  };

  system.stateVersion = "26.05";
}
