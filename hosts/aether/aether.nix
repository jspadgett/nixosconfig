#/hosts/aether/aether.nix
{ inputs, ... }: {
   flake.nixosConfigurations.aether = inputs.nixpkgs.lib.nixosSystem {
     system = "x86_64-linux";
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
       ../../modules/features/signal.nix
       ../../modules/features/kdeconnect.nix
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

       #--Desktop Features
       ../../modules/desktop/bluetooth.nix
       ../../modules/desktop/printing.nix
       ../../modules/desktop/audio-pro.nix        
       ../../modules/desktop/hyprland.nix
       ../../modules/desktop/kwallet.nix
       ../../modules/desktop/desktop-packages.nix
       ../../modules/desktop/nerdfonts.nix
       
       inputs.agenix.nixosModules.default
       inputs.home-manager.nixosModules.home-manager
       {
         home-manager.useGlobalPkgs = true;
         home-manager.useUserPackages = true;
         home-manager.users.joshua = import ../../modules/home/joshua/default.nix;
        }
     ];
   };
  }
