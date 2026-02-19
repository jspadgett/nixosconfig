# modules/features/appimage.nix
{ ... }: {
  # Enables running AppImage without manual extraction
  programs.appimage.enable = true;
}

