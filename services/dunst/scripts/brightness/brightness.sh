#!/bin/sh

iconPath="$HOME/nixos/modules/home-manager-modules/services/dunst/scripts/brightness/icons"

down() {
  light -U 5
  brightness=$(light -G)
  dunstify -a "BRIGHTNESS" "Decreasing to $brightness%" -h int:value:"$brightness" -i "$iconPath/bright1.svg" -r 2593 -u critical --timeout 3000
}

up() {
  light -A 5
  brightness=$(light -G)
  dunstify -a "BRIGHTNESS" "Increasing to $brightness%" -h int:value:"$brightness" -i "$iconPath/bright2.svg" -r 2593 -u critical --timeout 3000
}

case "$1" in
  up) up;;
  down) down;;
esac