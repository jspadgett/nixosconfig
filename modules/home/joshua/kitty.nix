#  /modules/home/joshua/kitty.nix
{ ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "CaskaydiaCove Nerd Font Mono";
      size = 14;
    };
    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      background_opacity = "0.4";
    };
    extraConfig = ''
    include ~/.cache/hyprland/colors-kitty.conf
  '';
 };
} 
