# modules/home/default.nix
{ pkgs, ... }: {
  home.username = "anna";
  home.homeDirectory = "/home/anna";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # Office
    libreoffice-qt

    # Media
    vlc
    spotify

    # Photo editing
    darktable

    # Utilities
    wget
    htop
    busybox
  ];
}

