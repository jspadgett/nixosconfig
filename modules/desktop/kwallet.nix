#/modules/desktop/kwallet.nix
{ pkgs, ... }:{ 
#
# Enables Kwallet
 
 security.pam.services.sddm.enableKwallet = true;
 environment.systemPackages = with pkgs; [
   kdePackages.kwallet-pam
 ];
}
