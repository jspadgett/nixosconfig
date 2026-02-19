#/modules/features/virtualisation.nix
{ ... }: { 
# 
# 
#This turns on basic virtualization
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  }
