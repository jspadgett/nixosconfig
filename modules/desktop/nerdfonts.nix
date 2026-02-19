#/modules/desktop/nerdfonts/nix
{ pkgs, ... }: {
#
#
# enable nerd fonts
 fonts.packages = [ 
   pkgs.nerd-fonts.jetbrains-mono
   pkgs.font-awesome
   pkgs.font-awesome_5
   ]; 
 }
