#/modules/common/base.nix
{ pkgs, inputs, ... }:
{
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
    inputs.agenix.packages.${pkgs.system}.default
 ];
   environment.pathsToLink = [
     "/share/applications"
     "/share/xdg-desktop-portal"
   ];
  }
