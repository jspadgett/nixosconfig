# /modules/features/signal.nix
#
# This used to wrap signal-desktop with --password-store=kwallet6, from when
# aether ran Plasma. Nothing has provided a wallet since the move to Hyprland:
# no kwalletd, and security.pam.services.sddm.enableKwallet is false. Electron
# therefore fell back to no backend and Signal wrote its database key in
# plaintext to ~/.config/Signal/config.json ("key" rather than "encryptedKey").
#
# The flag was doing nothing, so it is gone rather than left implying a
# protection that was not there. Encrypting the key for real needs a keyring
# PAM can unlock, which autoLogin prevents — no password is entered at login,
# so any backend would prompt on first use. That is a separate decision.
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.signal;
in
{
  options.jsp.signal.enable = lib.mkEnableOption "Signal Desktop";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.signal-desktop ];
  };
}
