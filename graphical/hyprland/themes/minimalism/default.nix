{ pkgs, config, ... }:
{
  imports = [
    ./waybar
  ];
  wayland.windowManager.hyprland.extraConfig = import ./hyprland.conf;
}