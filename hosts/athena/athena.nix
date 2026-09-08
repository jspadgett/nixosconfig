#   /hosts/athena/athena.nix
{ inputs, ... }: {
  flake.nixosConfigurations.athena = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      # Every NixOS module under modules/, inert until switched on by a
      # jsp.<name>.enable flag in ./configuration.nix.
      ../../modules
      ./configuration.nix

      inputs.agenix.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # joshua's home config is a Hyprland workstation setup (waybar,
        # hyprpaper, hyprlock, wine, bottles). athena runs COSMIC and he only
        # ever logs in over SSH, so it does not belong here. He still has an
        # account via configuration.nix, joshua-sshkeys and joshua-password.
        home-manager.users.anna = import ../../modules/home/anna/default.nix;
      }
    ];
  };
}
