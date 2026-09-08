# modules/desktop/kwallet.nix
{ config, lib, ... }:
let
  cfg = config.jsp.kwallet;
in
{
  # Built but not enabled on any host. Note this only wires up the PAM hook —
  # it does not install kwalletd, so enabling it alone would not give you a
  # working wallet.
  options.jsp.kwallet.enable =
    lib.mkEnableOption "KWallet, unlocked by the SDDM PAM stack";

  config = lib.mkIf cfg.enable {
    security.pam.services.sddm.enableKwallet = true;
  };
}
