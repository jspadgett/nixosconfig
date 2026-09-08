# modules/default.nix
#
# Imports every NixOS module in this tree. A module is inert until switched on
# by its jsp.<name>.enable flag in the host's configuration.nix, so importing
# all of them on every host costs nothing — a disabled module contributes no
# config, which is why the toplevel derivations did not move when this landed.
#
# The point is that a host's module list stops being the thing that decides
# what is enabled. Hosts declare intent in one place (their jsp.* flags) and
# nothing has to be added or removed here to turn a feature on.
#
# modules/home/ is deliberately excluded: those are home-manager modules,
# evaluated in a different option namespace, and are wired per-user in each
# host file's home-manager block.
{ lib, ... }:
let
  self = toString ./default.nix;

  isNixFile = p: lib.hasSuffix ".nix" (toString p);
  isHomeModule = p: lib.hasInfix "/modules/home/" (toString p);
  isSelf = p: toString p == self;
in
{
  imports = lib.filter
    (p: isNixFile p && !isHomeModule p && !isSelf p)
    (lib.filesystem.listFilesRecursive ./.);
}
