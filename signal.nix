# /etc/nixos/signal.nix
#
# This module handles the custom Signal Desktop wrapper
# that forces kwallet6 as the password store.
{ config, pkgs, ... }:

let
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
  # The module system will MERGE this list with the one from
  # configuration.nix automatically. You don't need to worry
  # about conflicts — NixOS concatenates list-type options.
  environment.systemPackages = [ signal-with-kwallet ];
}
