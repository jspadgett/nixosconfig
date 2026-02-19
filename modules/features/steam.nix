# /modules/features/tailscale.nix
{ ... }: {

#
#Enables Steam
   programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Opens ports in the firewall for steam Remote>
      dedicatedServer.openFirewall = true; # Opens ports for source dedicated server
   };  
   }
