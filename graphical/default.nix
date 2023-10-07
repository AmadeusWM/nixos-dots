{ pkgs, config, ... }:
{
  imports = [
    ./hyprland
    # ./i3
    ./launchers
    ./gnome
    ./apps
  ];
}