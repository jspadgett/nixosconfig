# /hosts/aether/configuration.nix
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # ── Module toggles ────────────────────────────────────────────────────
  # Modules under modules/ expose their own jsp.* enable flag. Turning a
  # feature on happens here, not by adding or removing an import.
  jsp.tailscale.enable = true;
  jsp.networkmanager.enable = true;
  jsp.ssh.enable = true;
  jsp.mtr.enable = true;
  jsp.gpgagent.enable = true;
  jsp.mullvad.enable = true;
  jsp.appimage.enable = true;
  jsp.flatpak.enable = true;
  jsp.signal.enable = true;
  jsp.amdgpu.enable = true;
  jsp.virtualisation.enable = true;
  jsp.steam.enable = true;
  jsp.joshua-ssh-private-key.enable = true;
  # jsp.gvfs stays off: desktop/hyprland.nix already enables services.gvfs.
  # jsp.kdeconnect is imported but left off — see modules/features/kdeconnect.nix.

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # /boot is a 511M ESP and each generation costs ~35M (kernel + initrd).
  # Unbounded, it fills at ~14 generations and breaks nixos-rebuild switch.
  # nix.gc does NOT prune the ESP — only this does, at switch time.
  boot.loader.systemd-boot.configurationLimit = 8;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # No swapDevices and no zram means the kernel's only response to memory
  # pressure is the OOM killer. zram gives it a graceful middle option without
  # consuming any of the already-scarce disk, which matters for Blender,
  # Proton shader compilation, libvirtd guests and emulated aarch64 builds.
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

networking.hostName = "aether"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  #    
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joshua = {
    isNormalUser = true;
    description = "joshua";
    # "plugdev" removed: it is a Debian/Arch convention and no such group
    # exists on NixOS, which grants device access via logind uaccess instead —
    # the entry was silently inert.
    # "libvirtd" added: the group exists and virtualisation.nix enables
    # libvirtd + virt-manager, but joshua was not a member, so every VM
    # operation went through a polkit password prompt.
    extraGroups = [ "networkmanager" "wheel" "dialout" "docker" "video" "render" "libvirtd" ];

  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "joshua";
  # The Hyprland package ships both hyprland.desktop and hyprland-uwsm.desktop.
  # autoLogin skips the greeter, so with no default SDDM falls back to its
  # last-used state file — nondeterministic on a fresh boot. Declare the UWSM
  # session explicitly: programs.hyprland.withUWSM is true, and sunshine's user
  # service depends on the graphical-session.target ordering UWSM sets up.
  services.displayManager.defaultSession = "hyprland-uwsm";

  # List packages installed in system profile. To search, run:
  modules.desktop.claude-code.enable = true;
  modules.desktop.openmw.enable = true;

  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sesssions
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;
  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system 
  # were taken. It‘s perfectly fine and recommended to leave this value at the release version of the first install of this system. Before changing this 
  # value read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

