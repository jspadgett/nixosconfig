# modules/home/default.nix
{ pkgs, ... }: {
  home.username = "joshua";
  home.homeDirectory = "/home/joshua";
  home.stateVersion = "25.11";
}
