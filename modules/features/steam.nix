# /modules/features/steam.nix
{ pkgs, ... }: {
  # Enables Steam
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [ gamescope ];
    };
    remotePlay.openFirewall = true;      # Opens ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Opens ports for Source dedicated server
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}
