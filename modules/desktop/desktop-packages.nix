#/modules/desktop/desktop-packages.nix
{ pkgs, ... }: {
#
# General packages for all systems
  environment.systemPackages = with pkgs; [
    jellyfin-media-player
    wget
    unzip
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    imagemagick
    file-roller
    vlc
    yt-dlp
    fastfetch
    popsicle
    p7zip
    lm_sensors
    mkvtoolnix
    ffmpeg
    ffmpegthumbnailer          # video thumbnails for GTK file managers (Hyprland)
    tmux
    (symlinkJoin {
      name = "darktable-nfs";
      paths = [ darktable ];
      nativeBuildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/darktable \
          --add-flags "--configdir /mnt/darktable/config"
      '';
    })
  ];
}
