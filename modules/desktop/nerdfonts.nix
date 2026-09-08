# modules/desktop/nerdfonts.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.jsp.nerdfonts;
in
{
  options.jsp.nerdfonts.enable =
    lib.mkEnableOption "the desktop font set: Nerd Font, Font Awesome and broad Unicode coverage";

  config = lib.mkIf cfg.enable {
    fonts = {
      # Pulls dejavu / liberation / gyre / unifont + noto-fonts-color-emoji
      # for broad Unicode coverage and color emoji.
      enableDefaultPackages = true;

      packages = with pkgs; [
        nerd-fonts.jetbrains-mono   # terminal/editor + patched icon glyphs
        font-awesome                # latest FA; needed if a config asks for the family by name
        font-awesome_5              # keep ONLY if something references Font Awesome 5 specifically
      ];

      fontconfig.defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
