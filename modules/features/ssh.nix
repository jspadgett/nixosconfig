# /modules/features/ssh.nix
{ config, lib, ... }:
let
  cfg = config.jsp.ssh;
in
{
  options.jsp.ssh.enable = lib.mkEnableOption "the OpenSSH daemon";

  config = lib.mkIf cfg.enable {
    # Still stock. Worth hardening (PasswordAuthentication, PermitRootLogin)
    # when more hosts are added.
    services.openssh.enable = true;
  };
}
