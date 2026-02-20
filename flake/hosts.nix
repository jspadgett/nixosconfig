# /home/joshua/nixos-config/flake/hosts.nix
{ inputs, ... }: {
  flake.nixosConfigurations = {

    aether = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        
        #--- Core modules
        ../modules/common/base.nix
        ../hosts/aether/configuration.nix
        
        #--- Networking 
        ../modules/features/networkmanager.nix
        ../modules/features/ssh.nix
        ../modules/features/tailscale.nix
        ../modules/features/mullvad.nix
        
        #-- Virtualization
        ../modules/features/virtualisation.nix
        ../modules/features/steam.nix


        #-- features        
        ../modules/features/signal.nix
        ../modules/features/kdeconnect.nix
        ../modules/features/appimage.nix
        ../modules/features/flatpak.nix
        ../modules/features/gvfs.nix
        ../modules/features/gpgagent.nix
        ../modules/features/mtr.nix
         #GPUSUPPORT
        ../modules/features/amdgpu.nix
        
        #--NAS Mounts
        ../modules/nas/slow2-nfs.nix

        #--Desktop Features
        ../modules/desktop/bluetooth.nix
        ../modules/desktop/printing.nix
        ../modules/desktop/audio-pro.nix        
        ../modules/desktop/hyprland.nix
        ../modules/desktop/kwallet.nix
        ../modules/desktop/desktop-packages.nix
        ../modules/desktop/nerdfonts.nix

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.joshua = import ../modules/home/joshua/default.nix;
        }
      ];
        # ── Athena (Laptop) ───────────────────────────────────────────
    athena = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [

        # ── Core ────────────────────────────────────────────────
        ../modules/common/base.nix
        ../hosts/athena/configuration.nix

        # ── Network ─────────────────────────────────────────────
        ../modules/features/networkmanager.nix
        ../modules/features/tailscale.nix
        ../modules/features/ssh.nix

        # ── Desktop ─────────────────────────────────────────────
        ../modules/desktop/cosmic.nix
        ../modules/desktop/audio-pro.nix
        ../modules/desktop/bluetooth.nix
        ../modules/desktop/printing.nix
        ../modules/desktop/nerdfonts.nix

        # ── Hardware ────────────────────────────────────────────
        ../modules/hardware/intel7-gpu.nix

        # ── Features ────────────────────────────────────────────
        ../modules/features/flatpak.nix
        ../modules/features/gvfs.nix
        ../modules/features/gpgagent.nix
        ../modules/features/mtr.nix
        ../modules/features/signal.nix

        # ── Home Manager ────────────────────────────────────────
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.joshua = import ../modules/home/joshua/default.nix;
          home-manager.users.anna = import ../modules/home/anna/default.nix;
        }

      ];

    
   };

  };
}
