#!/usr/bin/env bash

WALLPAPER="$1"

# Set wallpaper
swww img "$WALLPAPER" --transition-type fade --transition-fps 60

# Generate catppuccin-style colors
wallust run "$WALLPAPER"

# Reload Hyprland
hyprctl reload
