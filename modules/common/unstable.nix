# modules/common/unstable.nix
#
# ONE shared nixpkgs-unstable instantiation, exposed as `pkgs.unstable`.
#
# Why this file exists: `import inputs.nixpkgs-unstable { ... }` creates an
# entirely independent package set each time it is called. Two modules each
# doing that get two universes, and any package taken from both is built and
# stored twice — even at the identical upstream version, because a store path
# is derived from the full input closure, not the version string.
#
# Measured cost of getting this wrong on aether: 1.7G of unshared store paths
# for a single duplicated OpenMW, 1.1G for a duplicated Mesa, and the store
# held every version twice (mesa 26.1.6/26.2.0/26.2.1, wine 11.14, openmw
# 0.51.0 — each present as two differently-hashed copies).
#
# Use `pkgs.unstable.<package>`. Do NOT re-`import` nixpkgs-unstable in
# individual modules.
{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        # Derived from the platform being built rather than hardcoded to
        # x86_64-linux, so this module stays usable on hestia (aarch64).
        inherit (prev.stdenv.hostPlatform) system;
        # Inherit the system's nixpkgs config, including allowUnfree from
        # base.nix, instead of restating it here and letting it diverge.
        config = prev.config;
      };
    })
  ];
}
