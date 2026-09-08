# modules/home/joshua/default.nix
{ pkgs, ... }:
{
  imports = [
    ./kitty.nix  
    ./dunst.nix
    ./waybar.nix
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprland-config.nix
   ];
  home.username = "joshua";
  home.homeDirectory = "/home/joshua";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    #Browsers 
    brave
    #Themeing
    wallust                     # used by ./scripts/theme-switcher.sh; system copy dropped
    # imagemagick lives in modules/desktop/desktop-packages.nix — general tool,
    # kept at system level rather than in both profiles
    #development
    vscode  
    git
    quickemu
    freecad
    bottles
    # Stable 26.05 ships Wine staging 11.8; unstable ships 11.16. This used to
    # come from an overlay in hosts/aether/aether.nix that referenced
    # nixpkgs-unstable.legacyPackages directly — a third nixpkgs instantiation.
    # Sourcing it from the shared pkgs.unstable overlay keeps 11.16 while
    # sharing the whole dependency base with pkgs.unstable.openmw.
    unstable.wineWowPackages.staging
    #media
    handbrake
    mediawriter
    reaper
    obs-studio
    makemkv
    libation
    qbittorrent
    vesktop
    #testing
    stress-ng
    s-tui
    #gaming
    ryubing
    protonup-qt
    bolt-launcher
    runelite
    ];
  home.file = {
    ".config/hypr/scripts".source = ./scripts;
    ".config/hypr/wallpapers".source = ./wallpapers;
 };
}


  
