{ config, lib, pkgs, inputs, ... }:

with lib;

let
  cfg = config.modules.desktop.openmw;
  unstable = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
   };
in
{
  options.modules.desktop.openmw = {
    enable = mkEnableOption "OpenMW (Morrowind engine replacement)";

    modsDir = mkOption {
      type = types.str;
      default = "/home/joshua/Games/openmw-mods";
      description = "Directory where extracted mod archives live (each mod in its own subfolder).";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
     unstable. openmw

      # MOMW Tools Pack (momw-configurator, tes3cmd, delta_plugin, etc.) ships
      # as generic FHS-expecting Linux binaries. steam-run wraps them in an
      # FHS-compatible environment so they run unmodified on NixOS, e.g.:
      #   steam-run ./momw-configurator-linux-amd64 config ...
      steam-run

      # umo itself ships as an AppImage, which needs FUSE to self-mount.
      # appimage-run handles the FUSE mount + FHS env in one wrapper:
      #   appimage-run ./umo setup
      appimage-run

      # umo's dependency check requires a `7z` on $PATH with working
      # RARv4/RARv5 extraction. Nixpkgs' p7zip-rar package advertises RAR
      # support but the codec isn't actually enabled without extra unfree
      # plumbing that didn't take effect here. The MOMW Tools Pack ships
      # its own working RAR-capable 7zmo binary (confirmed: `7zmo i`
      # lists RAR codecs) — so instead of fighting nixpkgs' unfree
      # override, just point `7z` at that directly.
      (lib.hiPrio (pkgs.writeShellScriptBin "7z" ''
        exec /home/joshua/openmw/momw-tools/7zmo "$@"
      ''))
      unrar

      # tes3cmd (bundled in the MOMW Tools Pack) ships as a PAR::Packer
      # self-extracting Perl binary that re-extracts a fresh unpatched copy
      # of itself into /tmp on every single invocation, which defeats any
      # attempt to patch its ELF interpreter for NixOS. It uses only core
      # Perl modules (Carp, Cwd, File::*, Getopt::Long, Storable, etc.), so
      # we run the extracted .pl source directly with plain Nix perl instead
      # of the broken binary wrapper. See ~/openmw/momw-tools/tes3cmd.pl.
      perl
    ];

    # umo invokes bundled tools (tes3cmd, delta_plugin, etc.) directly rather
    # than through our steam-run wrapper, so those binaries need a working
    # dynamic linker + libs at the standard FHS paths. nix-ld provides that
    # system-wide for any prebuilt Linux binary. tes3cmd specifically needs
    # libxcrypt's legacy libcrypt.so.1.
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      libxcrypt-legacy
    ];

    # Ensure the mods directory exists with correct ownership so
    # openmw-wizard / openmw-launcher don't need manual mkdir on first run.
    systemd.tmpfiles.rules = [
      "d ${cfg.modsDir} 0755 joshua users -"
    ];
  };
}
