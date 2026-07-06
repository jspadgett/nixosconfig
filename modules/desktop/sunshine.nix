# modules/features/sunshine.nix
# Sunshine game stream host (Moonlight clients connect to this).
# Import-is-enable: importing this module activates it.
#
# The upstream nixpkgs module already handles: uinput, udev rules,
# avahi mDNS discovery, and the systemd user service (tied to
# graphical-session.target). Only stream config lives here.
#
# NOTE: declaring `settings`/`applications` here means the web UI
# (https://localhost:47990) is read-only for those — config is
# nix-managed. Pairing/PIN still works through the web UI.
#
# Auto-resolution: on stream start the display switches to the
# Moonlight client's resolution/refresh (SUNSHINE_CLIENT_* env
# vars) and restores native on stream end. Handles both Plasma
# (kscreen-doctor) and Hyprland (hyprctl) sessions.
{ config, pkgs, ... }:

let
  # Native mode restored when the stream ends.
  nativeMode = "3840x1600@75";

  kscreen = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  jq = "${pkgs.jq}/bin/jq";
  awk = "${pkgs.gawk}/bin/awk";

  setMode = pkgs.writeShellScript "sunshine-res-set" ''
    set -eu
    W="''${SUNSHINE_CLIENT_WIDTH:-1920}"
    H="''${SUNSHINE_CLIENT_HEIGHT:-1080}"
    FPS="''${SUNSHINE_CLIENT_FPS:-60}"

    if [ -n "''${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
      OUT=$(${hyprctl} monitors -j | ${jq} -r '.[0].name')
      ${hyprctl} keyword monitor "$OUT,''${W}x''${H}@''${FPS},auto,1"
    else
      OUT=$(${kscreen} -o | ${awk} '/Output:/{print $3; exit}')
      ${kscreen} "output.''${OUT}.mode.''${W}x''${H}@''${FPS}"
    fi
  '';

  restoreMode = pkgs.writeShellScript "sunshine-res-restore" ''
    set -eu
    if [ -n "''${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
      OUT=$(${hyprctl} monitors -j | ${jq} -r '.[0].name')
      ${hyprctl} keyword monitor "$OUT,${nativeMode},auto,1"
    else
      OUT=$(${kscreen} -o | ${awk} '/Output:/{print $3; exit}')
      ${kscreen} "output.''${OUT}.mode.${nativeMode}"
    fi
  '';
in
{
  services.sunshine = {
    enable = true;
    autoStart = true;

    # CAP_SYS_ADMIN wrapper, required for DRM/KMS capture on Wayland.
    capSysAdmin = true;

    # TCP 47984/47989/47990/48010, UDP 47998-48000/48002/48010
    # (derived as offsets from settings.port = 47989).
    openFirewall = true;

    settings = {
      sunshine_name = "aether";

      # AMD VAAPI encoding on the RX 9070 XT
      encoder = "vaapi";
      adapter_name = "/dev/dri/renderD128";

      # KMS capture works on both Hyprland and Plasma Wayland
      capture = "kms";

      # Runs for every app: match client resolution on start,
      # restore native mode when the stream ends.
      global_prep_cmd = builtins.toJSON [
        {
          do = "${setMode}";
          undo = "${restoreMode}";
          elevated = "false";
        }
      ];
    };

    applications = {
      env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Desktop";
          image-path = "desktop.png";
        }
        {
          name = "Steam Big Picture";
          detached = [ "${pkgs.steam}/bin/steam steam://open/bigpicture" ];
          image-path = "steam.png";
          auto-detach = "true";
        }
      ];
    };
  };
}
