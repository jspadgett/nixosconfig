# modules/home/joshua/hyprland.nix
{ ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [
        ",preferred,auto,auto"
        "DP-4,preferred,auto,auto"
      ];

      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun";

      exec-once = [
        "sleep 1 && waybar"
        "/usr/lib/pam_kwallet_init"
        "wallust run /home/joshua/.config/hypr/wallpapers/lockscreen.jpg"
      ];

      env = [
        "XCURSOR_SIZE,15"
        "HYPRCURSOR_SIZE,15"
      ];

      source = [ "~/.cache/hyprland/colors-hyprland.conf" ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgb(F2FAF7) rgb(CB5364) 45deg";
        "col.inactive_border" = "rgb(000006)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1;
        inactive_opacity = 0.9;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgb(E4F0EC)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, l, exec, hyprlock"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, n, exec, hyprshot -m window"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindel = [
        # Volume controls
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        # Brightness controls (no-op on desktop, functional on laptop)
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        # Media controls
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
       ", XF86AudioPlay, exec, playerctl play-pause"
       ", XF86AudioPrev, exec, playerctl previous"
     ];

      bindm = [
        # Mouse window management
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      windowrulev2 = [
        # Steam
        "opacity 1.0 1.0,class:^(steam|Steam)$"
        "opacity 1.0 1.0,class:^(steam_app_.*)$"
        "opacity 1.0 1.0,class:^(proton)$"
        # Idle inhibit fullscreen
        "idleinhibit fullscreen, class:.*"
        # Studio One 7
        "fullscreen, class:^(com.presonus.studioapp7)$"
        "noborder, class:^(com.presonus.studioapp7)$"
        "noanim, class:^(com.presonus.studioapp7)$"
        "immediate, class:^(com.presonus.studioapp7)$"
        "opaque, class:^(com.presonus.studioapp7)$"
        "forcergbx, class:^(com.presonus.studioapp7)$"
        "float, class:^(com.presonus.studioapp7)$, title:^(.*Plugin.*)$"
        "float, class:^(com.presonus.studioapp7)$, title:^(.*VST.*)$"
        "float, class:^(com.presonus.studioapp7)$, title:^(.*Preferences.*)$"
        "float, class:^(com.presonus.studioapp7)$, title:^(.*Browser.*)$"
        "float, class:^(com.presonus.studioapp7)$, title:^(.*Mixer.*)$"
        # QEMU/Quickemu VMs
        "workspace 2 silent, class:^(.qemu-system-x86_64-wrapped)$"
        "pseudo, class:^(.qemu-system-x86_64-wrapped)$"
        "size 1920 1080, class:^(.qemu-system-x86_64-wrapped)$"
        "center, class:^(.qemu-system-x86_64-wrapped)$"
        "opacity 1.0 1.0, class:^(.qemu-system-x86_64-wrapped)$"
        "workspace 2 silent, title:^(.*quickemu.*)$"
        "pseudo, title:^(.*quickemu.*)$"
        "size 1920 1080, title:^(.*quickemu.*)$"
        "center, title:^(.*quickemu.*)$"
      ];
    };
  };
}
