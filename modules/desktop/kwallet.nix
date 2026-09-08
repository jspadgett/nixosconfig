# modules/desktop/kwallet.nix
{ config, lib, ... }:
let
  cfg = config.jsp.kwallet;
in
{
  # Built but not enabled on any host. Note that features/signal.nix wraps
  # Signal with --password-store=kwallet6, which only does anything when this
  # is on — worth resolving one way or the other.
  options.jsp.kwallet.enable =
    lib.mkEnableOption "KWallet, unlocked by the SDDM PAM stack";

  config = lib.mkIf cfg.enable {
    security.pam.services.sddm.enableKwallet = true;
  };
}
