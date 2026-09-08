#/hosts/aether/aether.nix
{ inputs, ... }: {
  flake.nixosConfigurations.aether = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      # Every NixOS module under modules/. They are inert until switched on by
      # a jsp.<name>.enable flag, which lives in ./configuration.nix — that is
      # the single place describing what this host actually runs.
      ../../modules
      ./configuration.nix

      inputs.agenix.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # Without this, a pre-existing unmanaged dotfile that collides with a
        # managed one aborts the entire activation — and therefore the whole
        # nixos-rebuild switch. With it, the file is renamed and activation
        # continues. Sweep leftovers with:
        #   find ~ -name '*.hm-bak' -newer /run/current-system
        home-manager.backupFileExtension = "hm-bak";
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.joshua = import ../../modules/home/joshua/default.nix;
      }
    ];
  };
}
