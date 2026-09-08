# /modules/features/mtr.nix
{ config, lib, ... }:
let
  cfg = config.jsp.mtr;
in
{
  options.jsp.mtr.enable = lib.mkEnableOption "mtr, combined traceroute and ping";

  config = lib.mkIf cfg.enable {
    programs.mtr.enable = true;
  };
}
