#   /hosts/athena/athena.nix
{ inputs, ... }: {
    flake.nixosConfigurations.athena = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [

        # ── Core ────────────────────────────────────────────────
        ../../modules/common/base.nix
        ./configuration.nix

        # ── Network ─────────────────────────────────────────────
        ../../modules/features/networkmanager.nix
        ../../modules/features/tailscale.nix
        ../../modules/features/ssh.nix

        # ── Desktop ─────────────────────────────────────────────
        ../../modules/desktop/cosmic.nix
        ../../modules/desktop/audio.nix
        ../../modules/desktop/bluetooth.nix
        ../../modules/desktop/printing.nix
        ../../modules/desktop/nerdfonts.nix

        # ── Hardware ────────────────────────────────────────────
        ../../modules/features/intel7-gpu.nix

        # ── Features ────────────────────────────────────────────
        ../../modules/features/flatpak.nix
        ../../modules/features/gvfs.nix
        ../../modules/features/gpgagent.nix
        ../../modules/features/mtr.nix
        ../../modules/features/signal.nix

        #--Agenix
        inputs.agenix.nixosModules.default



        # ── Home Manager ────────────────────────────────────────
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.joshua = import ../../modules/home/joshua/default.nix;
          home-manager.users.anna = import ../../modules/home/anna/default.nix;
        }

      ];

    
   };
 }
