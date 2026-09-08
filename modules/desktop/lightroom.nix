# modules/desktop/lightroom.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.lightroom;

  # Stable staging, 11.8. wineWow64Packages is the single 64-bit build using
  # Wine's new WoW64 mode; wineWowPackages (the old paired 32/64 build) is
  # deprecated upstream. Lightroom is 64-bit, so the new mode is fine.
  wine = pkgs.wineWow64Packages.staging;

  # The recipe's prefix. Override at runtime with LR_PREFIX=... if you move it.
  defaultPrefix = "$HOME/src/lightroom-cc-on-linux/wineprefix";

  lightroom = pkgs.writeShellScriptBin "lightroom" ''
    set -euo pipefail
    prefix="''${LR_PREFIX:-${defaultPrefix}}"
    if [ ! -d "$prefix" ]; then
      echo "Lightroom prefix not found at $prefix" >&2
      echo "Set LR_PREFIX or run the recipe bootstrap first." >&2
      exit 1
    fi
    export LD_PRELOAD=
    export DXVK_CONFIG_FILE="$prefix/dxvk.conf"
    export WINEPREFIX="$prefix"
    export WINEARCH=win64
    export WINEDEBUG="''${WINEDEBUG:--all,err+all,fixme-all}"
    export DISPLAY="''${DISPLAY:-:0}"
    # Kill all wine processes in the prefix when Lightroom closes (no lingering daemons)
    trap '${wine}/bin/wineserver -k || true' EXIT
    exec ${wine}/bin/wine \
      "C:\\Program Files\\Adobe\\Adobe Lightroom CC\\lightroom.exe" "$@"
  '';

  lightroomDesktop = pkgs.makeDesktopItem {
    name = "lightroom-cc";
    desktopName = "Adobe Lightroom CC";
    exec = "lightroom";
    comment = "Adobe Lightroom CC (Wine)";
    categories = [ "Graphics" "Photography" ];
  };
in
{
  # Built but not enabled on any host — it depends on a Wine prefix bootstrapped
  # out-of-band by the lightroom-cc-on-linux recipe.
  options.jsp.lightroom.enable =
    lib.mkEnableOption "Adobe Lightroom CC under Wine";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ lightroom lightroomDesktop ];
  };
}
