# /hosts/hestia/hestia.nix
{ inputs, ... }: {
  flake.nixosConfigurations.hestia = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      # ── Hardware (RK3399 quirks: DTB, kernel, touchpad/kbd, efifb=off) ──
      inputs.nixos-hardware.nixosModules.pine64-pinebook-pro
      inputs.pinebook-pro.nixosModules.default

      # Every NixOS module under modules/, inert until switched on by a
      # jsp.<name>.enable flag in ./configuration.nix.
      ../../modules
      ./configuration.nix

      inputs.agenix.nixosModules.default

      # No home-manager users on this host, but desktop/claude-code.nix defines
      # home-manager.users.joshua.*. mkIf false suppresses the value, not the
      # option path, so the module system still requires the option to exist.
      # Importing every module everywhere means every host needs the frameworks
      # any module references.
      inputs.home-manager.nixosModules.home-manager
    ];
  };
}
