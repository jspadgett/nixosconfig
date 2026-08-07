# /hosts/hestia/hardware-configuration.nix   (TEMPORARY — replaced on first install)
{ ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };
}
