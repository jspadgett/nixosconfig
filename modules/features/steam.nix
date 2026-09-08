# /modules/features/steam.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.steam;
in
{
  options.jsp.steam.enable = lib.mkEnableOption "Steam, with gamescope in its runtime";

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      # gamescope has to be inside the Steam runtime for the "Enable Game
      # Mode" launch option; programs.gamescope only puts it on the host PATH.
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
  };
}
