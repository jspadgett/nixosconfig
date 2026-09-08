#/hosts/aether/aether.nix
{ inputs, ... }: {
   flake.nixosConfigurations.aether = inputs.nixpkgs.lib.nixosSystem {
     system = "x86_64-linux";
     specialArgs = { inherit inputs; };
     modules = [
        
       #--- Core modules
       ../../modules/common/base.nix
       ../../modules/common/joshua-sshkeys.nix
       ../../modules/common/unstable.nix
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
       # gvfs.nix not imported: desktop/hyprland.nix already enables it, and
       # services.gvfs.enable is types.bool (mergeEqualOption), so the two
       # definitions were legal only while both said true. The module file
       # stays for athena, which uses it without hyprland.nix.
       ../../modules/features/gpgagent.nix
       ../../modules/features/mtr.nix
       ../../modules/features/joshua-password.nix 
       #GPUSUPPORT
       ../../modules/features/amdgpu.nix
        
       #--NAS Mounts
       ../../modules/nas/slow2-nfs.nix
       ../../modules/nas/darktable-nfs.nix
       #--Desktop Features
      ../../modules/desktop/openmw.nix 
      ../../modules/desktop/bluetooth.nix
       ../../modules/desktop/printing.nix
       ../../modules/desktop/audio-pro.nix        
      # ../../modules/desktop/plasma.nix
       ../../modules/desktop/hyprland.nix
      # ../../modules/desktop/kwallet.nix
       ../../modules/desktop/desktop-packages.nix
       ../../modules/desktop/nerdfonts.nix
      # ../../modules/desktop/lightroom.nix
       ../../modules/desktop/scheduler.nix
       ../../modules/desktop/sunshine.nix
       ../../modules/desktop/claude-code.nix
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

       # A Wine overlay used to live here, pulling wineWowPackages.staging from
       # nixpkgs-unstable.legacyPackages — a third nixpkgs instantiation on top
       # of the two `import`s in amdgpu.nix and openmw.nix.
       #
       # The version gap it exists for is real: stable 26.05 ships staging 11.8,
       # unstable ships 11.16. So this is not removed but relocated — see
       # modules/home/joshua/default.nix, which now takes it from the shared
       # pkgs.unstable overlay (modules/common/unstable.nix). Same 11.16, one
       # instantiation instead of three, and the version choice now sits at the
       # point of use rather than in a host-level overlay.
     ];
   };
  }
