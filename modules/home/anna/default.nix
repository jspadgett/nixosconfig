# modules/home/default.nix
{ pkgs, ... }: {
  # modules/home/anna/default.nix
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
    kdePackages.kdenlive

    # Photo editing
    darktable

    # Communication
    signal-desktop

    # Utilities
    wget
    htop
    busybox
  ];
}

