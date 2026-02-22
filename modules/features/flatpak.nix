# /modules/features/flatpak.nix
{ pkgs, ... }: {

#
#Enables FlatPak 
   services.flatpak.enable = true;
   xdg.portal = {
     enable = true;
     extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
   };
 }
