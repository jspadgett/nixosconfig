#/hosts/aether/aether.nix
{ inputs, ... }: {
   flake.nixosConfigurations.aether = inputs.nixpkgs.lib.nixosSystem {
     system = "x86_64-linux";
     specialArgs = { inherit inputs; };
     modules = [
        
       #--- Core modules
       ../../modules/common/base.nix
       ../../modules/common/joshua-sshkeys.nix
       ./configuration.nix
        
       #--- Networking 
       ../../modules/features/networkmanager.nix
       ../../modules/features/ssh.nix
       ../../modules/features/tailscale.nix
       ../../modules/features/mullvad.nix
        
       #-- Virtualization
       ../../modules/features/virtualisation.nix
       ../../modules/features/steam.nix
       #-- features        
       ../../modules/features/joshua-ssh-private-key.nix
       ../../modules/features/signal.nix
      # ../../modules/features/kdeconnect.nix
       ../../modules/features/appimage.nix
       ../../modules/features/flatpak.nix
       ../../modules/features/gvfs.nix
       ../../modules/features/gpgagent.nix
       ../../modules/features/mtr.nix
       ../../modules/features/joshua-password.nix 
       #GPUSUPPORT
       ../../modules/features/amdgpu.nix
        
       #--NAS Mounts
       ../../modules/nas/slow2-nfs.nix
       ../../modules/nas/darktable-nfs.nix
       #--Desktop Features
       ../../modules/desktop/bluetooth.nix
       ../../modules/desktop/printing.nix
       ../../modules/desktop/audio-pro.nix        
       ../../modules/desktop/plasma.nix
       ../../modules/desktop/hyprland.nix
      # ../../modules/desktop/kwallet.nix
       ../../modules/desktop/desktop-packages.nix
       ../../modules/desktop/nerdfonts.nix
      # ../../modules/desktop/lightroom.nix
       ../../modules/desktop/scheduler.nix
       ../../modules/desktop/sunshine.nix
       inputs.agenix.nixosModules.default
       inputs.home-manager.nixosModules.home-manager
       {
         home-manager.useGlobalPkgs = true;
         home-manager.useUserPackages = true;
         home-manager.extraSpecialArgs = { inherit inputs; }; 
         home-manager.users.joshua = import ../../modules/home/joshua/default.nix;
        }

       # Wine from unstable — stable 25.11 ships 10.20, Lightroom needs >= 11.8
       {
         nixpkgs.overlays = [
           (final: prev: {
             wineWowPackages = prev.wineWowPackages // {
               staging = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.wineWowPackages.staging;
             };
           })
         ];
       }
     ];
   };
  }
