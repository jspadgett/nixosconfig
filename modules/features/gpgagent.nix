# /modules/features/gpgagent.nix
{ config, lib, ... }:
let
  cfg = config.jsp.gpgagent;
in
{
  options.jsp.gpgagent.enable =
    lib.mkEnableOption "the GPG agent, standing in for ssh-agent so a GPG key can authenticate over SSH";

  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
