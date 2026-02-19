# modules/home/joshua/default.nix
{ pkgs, ... }: {
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
    firefox
    brave
    
    #development
    vscode  
    git
    quickemu
    freecad
    bottles
    wine-staging
    #media
    handbrake
    mediawriter
    reaper
    darktable
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


  
