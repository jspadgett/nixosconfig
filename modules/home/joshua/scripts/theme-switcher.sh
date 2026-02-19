#!/usr/bin/env bash
# ~/.config/hypr/scripts/theme-switcher.sh

WALLPAPER="$1"

# Generate color scheme from wallpaper
wal -i "$WALLPAPER" -n

# Reload Hyprland colors
hyprctl reload
