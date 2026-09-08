#/modules/common/base.nix
{ config, lib, pkgs, inputs, ... }:
let
  # Normal users with no declarative password source of any kind.
  passwordless = lib.filter
    (u: u.hashedPassword == null
     && u.hashedPasswordFile == null
     && u.password == null
     && u.initialPassword == null
     && u.initialHashedPassword == null)
    (lib.filter (u: u.isNormalUser) (lib.attrValues config.users.users));
in
{
  # Guard against a password module being imported but left disabled.
  #
  # nixpkgs has its own check, but it only requires that ONE privileged
  # account has a password OR an SSH key — so on a host where joshua is in
  # wheel with authorized keys, it passes even if every other user has no
  # password at all. With mutableUsers = false, /etc/shadow is regenerated
  # from config on each activation, so that means a silent lockout for
  # everyone else. This makes it a build error instead.
  assertions = [
    {
      assertion = config.users.mutableUsers || passwordless == [ ];
      message = ''
        users.mutableUsers is false, but these normal users have no password
        source and would be locked out: ${lib.concatMapStringsSep ", " (u: u.name) passwordless}.
        Set hashedPasswordFile (see modules/features/*-password.nix and its
        jsp.*.enable flag), or set users.mutableUsers = true.
      '';
    }
  ];

#boot latest kernel
boot.kernelPackages = pkgs.linuxPackages_latest;
#Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
# Retention policy for the Nix store. Without this, every build artefact ever
# produced stays on disk forever. An empty gc.options only reaps already-dead
# paths; --delete-older-than first drops old generation links, which un-roots
# their closures and is what actually reclaims space.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
# Weekly hard-link dedup pass. Deletes nothing; replaces identical files across
# store paths with links to one copy. Preferred over
# nix.settings.auto-optimise-store, which does the same work synchronously at
# the end of every single build instead of in one scheduled window.
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];
# Set your time zone.
  time.timeZone = "America/New_York";
# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
#Enable unfree packages
  nixpkgs.config.allowUnfree = true;
# enable polkit
  security.polkit.enable = true;
#Enable firefox
   programs.firefox.enable = true;
# Enable agenix
   environment.systemPackages = [
    # pkgs.system is deprecated in favour of pkgs.stdenv.hostPlatform.system
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
 ];
# environment.pathsToLink for /share/applications and /share/xdg-desktop-portal
# removed: both are already in the NixOS default set, so adding them produced
# /share/applications three times and /share/xdg-desktop-portal twice.
  }
