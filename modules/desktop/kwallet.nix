#/modules/desktop/kwallet.nix
{ pkgs, ... }:{ 
#
# Enables Kwallet
 
 security.pam.services.sddm.enableKwallet = true;
}
