# modules/home/default.nix
{ pkgs, ... }: {
imports = [
  ./kitty.nis




  home.username = "joshua";
  home.homeDirectory = "/home/joshua";
  home.stateVersion = "25.11";
}
