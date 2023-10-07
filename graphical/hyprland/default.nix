{ config, pkgs, ...}:

{
  imports = [
    ./config
    ./themes
  ];
  
  wayland.windowManager.hyprland.enable = true;

  # Waybar with experimental for wlr/workspaces (source: https://www.reddit.com/r/hyprland/comments/1302f09/how_do_i_use_waybarhyprland_on_nixos/)
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };
}