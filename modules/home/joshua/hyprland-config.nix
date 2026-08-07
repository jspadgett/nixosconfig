# modules/home/joshua/hyprland-config.nix
{ osConfig, lib, ... }:

lib.mkIf (osConfig.programs.hyprland.enable or false) {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      workspace = [
        "3, layout:master, layoutopt:orientation:center, layoutopt:mfact:0.50"
      ];

      monitor = [
          "desc:LG Electronics LG HDR WQHD+ 406NTAB4W648, 3840x1600@75, 0x0, 1"
          ", preferred, auto, 1"
      ];

      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun";

      exec-once = [
        "sleep 1 && waybar"
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
        allow_tearing = true;
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
          "windows, 1, 2.8, easeOutQuint"
          "windowsIn, 1, 2.4, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.2, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 2.5, easeOutQuint"
          "layersIn, 1, 2.8, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.2, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.2, almostLinear, fade"
        ];
      };

      dwindle = {
        # NOTE: dwindle:pseudotile was removed in 0.55 (it did nothing).
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        mfact = 0.50;
        orientation = "center";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        vrr = 2;
        # NOTE: misc:vfr moved to debug:vfr in 0.55 (see debug block below).
      };

      debug = {
        vfr = true;
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
        # NOTE: togglesplit dispatcher removed in 0.54 -> call via layoutmsg.
        "$mainMod, J, layoutmsg, togglesplit"
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
        "$mainMod, Plus, layoutmsg, addmaster"
        "$mainMod, Minus, layoutmsg, removemaster"
        "$mainMod SHIFT, M, layoutmsg, swapwithmaster"
        "$mainMod, F11, fullscreen, 0"
        "$mainMod CTRL, C, exec, hyprctl dispatch workspace 3 && sleep 0.2 && firefox & sleep 0.5 && vesktop & sleep 0.3 && signal-desktop &"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # ---------------------------------------------------------------------
      # Window rules — migrated to the 0.55 syntax.
      #   props are prefixed with `match:`  (class/title/xwayland/float/...)
      #   boolean effects take `on`/`off`   (float on, center on, ...)
      #   matcher renames: floating -> float, pinned -> pin
      #   effect renames:  suppressevent -> suppress_event,
      #                    idleinhibit   -> idle_inhibit,
      #                    noblur        -> no_blur
      # windowrulev2 has been folded into windowrule; PreSonus rules removed.
      # ---------------------------------------------------------------------
      windowrule = [
        # Stop empty XWayland surfaces from stealing focus on spawn.
        # (old `nofocus` -> `no_initial_focus`; if the bool matchers below
        #  ever throw, drop to just: "match:class ^$, match:xwayland 1, no_initial_focus on")
        "match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0, no_initial_focus on"

        # Let apps handle their own maximize instead of Hyprland.
        "match:class .*, suppress_event maximize"

        # Keep Steam / Proton windows fully opaque.
        "match:class ^(steam|Steam)$, opacity 1.0 1.0"
        "match:class ^(steam_app_.*)$, opacity 1.0 1.0"
        "match:class ^(proton)$, opacity 1.0 1.0"

        # Inhibit idle whenever anything is fullscreen.
        "match:class .*, idle_inhibit fullscreen"

        # QEMU / quickemu VMs -> workspace 2, pseudotiled, centered 1080p.
        "match:class ^(.qemu-system-x86_64-wrapped)$, workspace 2 silent, pseudo on, size 1920 1080, center on, opacity 1.0 1.0"
        "match:title ^(.*quickemu.*)$, workspace 2 silent, pseudo on, size 1920 1080, center on"

        # Browser + comms -> workspace 3.
        "match:class ^(firefox)$, workspace 3 silent"
        "match:class ^(vesktop)$, workspace 3 silent"
        "match:class ^(signal)$, workspace 3 silent"

        # Adobe Lightroom -> workspace 6.
        "match:class ^(lightroom\\.exe)$, workspace 6 silent, no_blur on, idle_inhibit focus"

        # Forza Horizon 6 -> workspace 4, fullscreen, tearing allowed.
        # (old `opaque` -> `opacity 1.0 override`, which forces an absolute value)
        "match:class (forzahorizon6.exe), fullscreen on, immediate on, workspace 4 silent, opacity 1.0 override, no_blur on"
      ];
    };
  };
}
