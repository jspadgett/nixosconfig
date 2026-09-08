# modules/desktop/claude-code.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.claude-code;
in
{
  # Renamed from modules.desktop.claude-code to jsp.* so the whole repo uses
  # one namespace.
  options.jsp.claude-code.enable = lib.mkEnableOption "the Claude Code CLI, for joshua";

  config = lib.mkIf cfg.enable {
    home-manager.users.joshua.home.packages = [ pkgs.claude-code ];
  };
}
