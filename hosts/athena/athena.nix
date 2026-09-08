#   /hosts/athena/athena.nix
{ inputs, ... }: {
    flake.nixosConfigurations.athena = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [

        # ── Core ────────────────────────────────────────────────
        ../../modules/common/base.nix
        ../../modules/common/joshua-sshkeys.nix
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
        ../../modules/features/joshua-ssh-private-key.nix
        ../../modules/features/flatpak.nix
        ../../modules/features/gvfs.nix
        ../../modules/features/gpgagent.nix
        ../../modules/features/mtr.nix
        ../../modules/features/signal.nix
        ../../modules/features/anna-password.nix
        ../../modules/features/joshua-password.nix
        ../../modules/features/tlp.nix
         #--Agenix
        inputs.agenix.nixosModules.default



        # ── Home Manager ────────────────────────────────────────
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
