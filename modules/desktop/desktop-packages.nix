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
    mkvtoolnix
    ffmpeg
    tmux

    (writeShellScriptBin "darktable" ''
      exec ${pkgs.darktable}/bin/darktable --configdir /mnt/darktable/config "$@"
    '')

    (pkgs.makeDesktopItem {
      name = "darktable";
      desktopName = "Darktable";
      exec = "darktable %F";
      icon = "darktable";
      categories = [ "Graphics" "Photography" ];
      comment = "Virtual lighttable and darkroom for photographers";
    })
  ];
}
