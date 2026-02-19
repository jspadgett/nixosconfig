# modules/home/joshua/dunst.nix
{ ... }: {
  services.dunst = {
   enable = true;
   settings = {
      global = {
        font = "JetBrains Mono 10";
        geometry = "300x50-30+30";
        origin = "top-right";   
        transparency = 5;
      padding = 10;
      horizontal_padding = 10;
      text_icon_padding = 8;
      frame_width = 2;
      frame_color = "#88C0D0";
      corner_radius = 8;
      background = "#2E3440";
      foreground = "#ECEFF4";
      separator_height = 2;
      separator_color = "auto";
      icon_theme = "Papirus-Dark";
      max_icon_size = 64;
      markup = "full";
      stack_duplicates = true;
      hide_duplicate_count = false;
      indicate_hidden = "yes";
      mouse_left_click = "close_current";
      mouse_middle_click = "close_all";
      mouse_right_click = "do_action";
      follow = "mouse";
      wayland = true;
      scale = 0;
      path = "~/.cache/dunst.log";
      verbosity = "mesg";
    };
      urgency_low = {
        background = "#3B4252";
        foreground = "#D8DEE9";
        frame_color = "#81A1C1";
        timeout = 3000;
      };
      urgency_normal = {
        background = "#2E3440";
        foreground = "#ECEFF4";
        frame_color = "#88C0D0";
        timeout = 5000;
      };
      urgency_critical = {
        background = "#BF616A";
        foreground = "#ECEFF4";
        frame_color = "#BF616A";
        timeout = 0;
      };
    };
  };
 }
