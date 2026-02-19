# /home/joshua/nixos-config/flake/hosts.nix
{ inputs, ... }: {
  flake.nixosConfigurations = {

    aether = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../modules/common/base.nix
        ../hosts/aether/configuration.nix
        ../modules/features/ssh.nix
        ../modules/features/virtualisation.nix
        ../modules/features/steam.nix
        ../modules/features/signal.nix
        ../modules/features/tailscale.nix
        ../modules/features/kdeconnect.nix
        ../modules/features/appimage.nix
        ../modules/features/flatpak.nix
        ../modules/features/mullvad.nix
        ../modules/features/networkmanager.nix
        ../modules/features/amdgpu.nix
        ../modules/features/gvfs.nix
        ../modules/features/gpgagent.nix
        ../modules/features/mtr.nix
        ../modules/nas/slow2-nfs.nix
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
    };

  };
}
