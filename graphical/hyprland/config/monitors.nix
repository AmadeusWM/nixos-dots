{ pkgs, ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    source = ~/nixos/home/dots/graphical/hyprland/config/conf/monitors.conf
  '';
}