{ config, pkgs, inputs, ...}:

{
  imports = [
    ./config
    ./dependencies.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    # plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprwinwrap
    # ];
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Waybar with experimental for wlr/workspaces (source: https://www.reddit.com/r/hyprland/comments/1302f09/how_do_i_use_waybarhyprland_on_nixos/)
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };
}
