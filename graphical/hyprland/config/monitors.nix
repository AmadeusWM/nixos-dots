{ pkgs, ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    source = ~/nixos-dotfiles/home/dots/graphical/hyprland/config/conf/monitors.conf
  '';
}