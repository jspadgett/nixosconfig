#/modiles/features/gvfs.nix
{ ... }: {

#enable mtp support for android devices 
  # GVFS (GNOME Virtual File System) provides virtual filesystem support.
  # Enables MTP protocol support for mounting Android devices and other
  # portable media over USB. Without this, file managers like Dolphin
 services.gvfs.enable = true; 
}
