# /modules/features/virtualisation.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.virtualisation;
in
{
  options.jsp.virtualisation.enable =
    lib.mkEnableOption "Docker, libvirtd and virt-manager";

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      package = pkgs.docker_29;
    };

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
