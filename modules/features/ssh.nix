# /modules/features/tailscale.nix
{ ... }: {

#
#Enables SSH come back and harden then when adding additional hoststs 
   services.openssh.enable = true;
   }
