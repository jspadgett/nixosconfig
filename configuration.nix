
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
#let
#  signal-with-kwallet = pkgs.symlinkJoin {
#    name = "signal-desktop";
#    paths = [ pkgs.signal-desktop ];
#    buildInputs = [ pkgs.makeWrapper ];
#    postBuild = ''
#      wrapProgram $out/bin/signal-desktop \
#        --add-flags "--password-store=kwallet6"
#    '';
#  };
#in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;


  networking.hostName = "nixietube"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
 # ROCm configuration
    boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
 # enable nerd fonts
 fonts.packages = [ 
         pkgs.nerd-fonts.jetbrains-mono
     ];
 # enable docker daemon
  virtualisation.docker.enable = true; 
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
#  services.desktopManager.plasma6.enable = true;
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
 hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
 # Enable kwallet 
  security.pam.services.sddm.enableKwallet = true;
 # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    };

# enable polkit
  security.polkit.enable = true;

  #Enable unfree packages  
    nixpkgs.config.allowUnfree = true;
  # Enable vm manager
    virtualisation.libvirtd.enable = true; programs.virt-manager.enable = true;
  # Enable sound with pipewire.
    hardware.pulseaudio.enable = false; security.rtkit.enable = true; services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

  
  # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
  #  media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # enables media drive mount for server2
  fileSystems."/mnt/media" = {
    device = "192.168.1.188:/mnt/slow2";
    fsType = "nfs";
  };
#enable mtp support for android devices 
 services.gvfs.enable = true;
# enable mullvad
 services.mullvad-vpn.enable = true;  
# enable Flatpak
services.flatpak.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joshua = {
    isNormalUser = true;
    description = "joshua";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      brave
      firefox
      p7zip
      vesktop  
      quickemu
      darktable
      reaper
      yt-dlp
      vlc
      handbrake
      mediawriter
      vscode
      git
      yabridge
      yabridgectl
      ryubing
#  thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "joshua";
  # enable expressvpn ?
  services.expressvpn.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     # Your custom Signal with kwallet6
#    signal-with-kwallet

   #other packages
   kdePackages.ark
    btop-rocm
    busybox
    wget
    virt-manager
    kdePackages.kwallet-pam
    obs-studio
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.th_TH
    wine-staging
    calf 
    bottles
    freecad
    blender-hip
    caprine
    qbittorrent
    kdePackages.kdeconnect-kde
    docker
    rocmPackages.clr
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    warp-terminal
    amdgpu_top
    appimage-run
    carla
    makemkv
    mullvad-vpn
    spotify
    waybar
    dunst
    libnotify
     hyprpaper
    kitty
    wofi
    font-awesome
    font-awesome_5
    hyprshot
    hyprlock
    kdePackages.qtsvg
    kdePackages.kio-fuse #mouts remote file systems
    kdePackages.kio-extras
    kdePackages.dolphin
    kdePackages.kio-admin
    hypridle
    unzip
    pavucontrol
    pywal
    imagemagick
    wallust
    swww
    blueman
    protonup-qt
    popsicle
    file-roller
    corectrl
    neofetch
    prismlauncher
    system-config-printer
    libmtp
    mtpfs
    android-file-transfer
    appimage-run
    bolt-launcher
    runelite
    radeontop
    lm_sensors
    stress-ng
    s-tui
    libation
    jellyfin-desktop
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Opens ports in the firewall for steam Remote play
      dedicatedServer.openFirewall = true; # Opens ports for source dedicated server
   };  



# List services that you want to enable:
  # programs.corectl.enable = true

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
  # Enable Tailscale
   services.tailscale.enable = true;
  #
  programs.corectrl.enable = true; 
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;
  # add udevrule for gpu 
  security.polkit.extraConfig = ''
  polkit.addRule(function(action, subject) {
    if ((action.id == "org.corectrl.helper.init" || action.id == "org.corectrl.helperkiller.init") && 
        subject.local == true && 
        subject.active == true && 
        subject.isInGroup("wheel")) {
      return polkit.Result.YES;
    }
  });
'';  

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system 
  # were taken. It‘s perfectly fine and recommended to leave this value at the release version of the first install of this system. Before changing this 
  # value read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

