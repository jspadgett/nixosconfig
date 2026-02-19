#/modules/desktop/desktop-packages.nix
{ pkgs, ... }: {
#
# General packages for all systems 
  environment.systemPackages = with pkgs; [
    jellyfin-desktop
    busybox
    wget
    unzip
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    imagemagick
    file-roller
    vlc
    yt-dlp
    neofetch
    popsicle
    p7zip
    lm_sensors
    ];
}
