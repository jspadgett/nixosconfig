# /modules/features/signal.nix
#
# Signal Desktop wrapped to force kwallet6 as its password store.
# NOTE: desktop/kwallet.nix is currently commented out on every host, so the
# wallet this points at is not actually enabled. Left as-is to keep the
# closure unchanged; worth revisiting.
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.signal;

  signal-with-kwallet = pkgs.symlinkJoin {
    name = "signal-desktop";
    paths = [ pkgs.signal-desktop ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/signal-desktop \
        --add-flags "--password-store=kwallet6"
    '';
  };
in
{
  options.jsp.signal.enable = lib.mkEnableOption "Signal Desktop, wrapped to use kwallet6";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ signal-with-kwallet ];
  };
}
