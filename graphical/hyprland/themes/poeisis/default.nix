{ pkgs, config, ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    bind=SUPERSHIFT,B,exec, ~/nixos-dotfiles/home/dots/graphical/hyprland/themes/poeisis/waybar/waybar.sh

    exec=~/nixos-dotfiles/home/dots/graphical/hyprland/themes/poeisis/waybar/waybar.sh
  '';
}