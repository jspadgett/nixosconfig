# modules/desktop/hyprland.nix — safe to import ALONGSIDE plasma.nix
{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;          # also enables xdg.portal + adds the version-synced hyprland portal
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    waybar dunst hyprpaper libnotify wofi hyprshot
    hyprlock wallust hypridle
    # hyprpaper (static) and swww (animated) are both wallpaper daemons — pick ONE
    # and drop the other; only whichever you exec-once actually runs.
    # hyprpolkitagent   # add + exec-once if you hit GUI privilege prompts outside the Plasma session
  ];

  # programs.hyprland already sets xdg.portal.enable and adds the hyprland portal
  # (synced to your Hyprland package). We only add GTK, for the file picker XDPH lacks.
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.hyprland.default = [ "hyprland" "gtk" ];
  # xdg.portal.config.common.default = [ "gtk" ];  # optional catch-all fallback
}
