# modules/desktop/claude-code.nix
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.desktop.claude-code;
in
{
  options.modules.desktop.claude-code = {
    enable = mkEnableOption "Claude Code CLI";
  };

  config = mkIf cfg.enable {
    home-manager.users.joshua.home.packages = [ pkgs.claude-code ];
  };
}
