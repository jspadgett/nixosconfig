# /modules/features/gpgagent.nix
{ ... }: {

#
#Enables gpg  agent and allows verification over ssh via gpg key 
  programs.gnupg.agent = {
  enable = true;
  enableSSHSupport = true;
 };
}
