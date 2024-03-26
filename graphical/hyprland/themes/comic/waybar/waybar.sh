#!/usr/bin/env sh

# Terminate already running bar instances
killall -q .waybar-wrapped

# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch main
waybar -c $HOME/nixos/modules/home-manager-modules/graphical/hyprland/themes/comic/waybar/config -s $HOME/nixos/modules/home-manager-modules/graphical/hyprland/themes/comic/waybar/style.css &
