#!/usr/bin/env sh

# Terminate already running bar instances
killall -q .waybar-wrapped

# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch main
waybar -c $HOME/nixos-dotfiles/home/dots/graphical/hyprland/themes/poeisis/waybar/config -s $HOME/nixos-dotfiles/home/dots/graphical/hyprland/themes/poeisis/waybar/style.css &
