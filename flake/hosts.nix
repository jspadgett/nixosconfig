# /home/joshua/nixos-config/flake/hosts.nix
{ ... }: {
  imports = [
    ../hosts/aether/aether.nix
    ../hosts/athena/athena.nix
  ]; 
}
