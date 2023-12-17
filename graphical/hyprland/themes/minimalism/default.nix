{ pkgs, config, ... }:
{
  imports = [
    ./waybar
  ];
  wayland.windowManager.hyprland.extraConfig = builtins.readFile ./hyprland.conf;
}
