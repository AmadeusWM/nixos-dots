{ pkgs, config, ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    bind=SUPERSHIFT,B,exec, ~/nixos/home/dots/graphical/hyprland/themes/poeisis/waybar/waybar.sh

    exec=~/nixos/home/dots/graphical/hyprland/themes/poeisis/waybar/waybar.sh
  '';
}