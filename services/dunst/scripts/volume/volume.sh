#!/bin/sh

iconPath="$HOME/nixos/modules/home-manager-modules/services/dunst/scripts/volume/icons"

down() {
  pamixer -d 5
  volume=$(pamixer --get-volume)
  [$volume -gt 0 ] && volume=`expr $volume`  
  dunstify "Volume" "Decreasing to $volume%" -h int:value:"$volume" -i "$iconPath/vol2.svg" -r 2593 -u low
  canberra-gtk-play -i audio-volume-change -d "changevolume"
}

up() {
  pamixer -i 5
  volume=$(pamixer --get-volume)
  [ $volume -lt 100 ] && volume=`expr $volume`  
  dunstify "Volume" "Increasing to $volume%" -h int:value:"$volume" -i "$iconPath/vol3.svg" -r 2593 -u low
  # canberra-gtk-play -i audio-volume-change -d "changevolume"
}

mute() {
  muted="$(pamixer --get-mute)"
  if $muted; then
    pamixer -u
    dunstify "Volume" "Unmuted" -i "$iconPath/vol3.svg" -r 2593 -u low
  else 
    pamixer -m
    dunstify "Volume" "Muted" -i "$iconPath/vol0.svg" -r 2593 -u low
  fi
}

case "$1" in
  up) up;;
  down) down;;
  mute) mute;;
esac