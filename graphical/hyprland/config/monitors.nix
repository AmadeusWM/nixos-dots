{ pkgs, ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    source = ~/nixos/modules/home-manager-modules/graphical/hyprland/config/conf/monitors.conf
  '';
}
