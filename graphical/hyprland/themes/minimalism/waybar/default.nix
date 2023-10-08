{ config, pkgs, ...}:

{
  programs.waybar = {
    enable = true;
    settings = import ./config.nix;
    style = import ./style.nix;
  };
}