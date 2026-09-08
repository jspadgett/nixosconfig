# /hosts/hestia/hestia.nix
{ inputs, ... }: {
  flake.nixosConfigurations.hestia = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      # ── Hardware (RK3399 quirks: DTB, kernel, touchpad/kbd, efifb=off) ──
      inputs.nixos-hardware.nixosModules.pine64-pinebook-pro
      inputs.pinebook-pro.nixosModules.default
      # ── Core ──
      ../../modules/common/base.nix
      ../../modules/common/joshua-sshkeys.nix
      ./configuration.nix

      # ── Desktop ──
      ../../modules/desktop/xfce.nix
      ../../modules/desktop/audio.nix

      # ── Network ──
      ../../modules/features/networkmanager.nix
      ../../modules/features/ssh.nix
      ../../modules/features/tailscale.nix
      # ── Features ──
      ../../modules/features/mtr.nix
      ../../modules/features/gpgagent.nix
      ../../modules/features/joshua-password.nix
      ../../modules/features/melissa-password.nix
      ../../modules/features/pinepacks.nix
      inputs.agenix.nixosModules.default
    ];
  };
}
