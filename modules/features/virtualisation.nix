# /modules/features/virtualisation.nix
{ pkgs, ... }:
{
  # Basic virtualization
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
