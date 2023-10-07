{ pkgs, config, ... }:
{
  enable = true;
  # platformTheme = "gtk"; # just an override for QT_QPA_PLATFORMTHEME, takes "gtk" or "gnome"
  style = {
    package = pkgs.catppuccin-kde;
    name = "Catpuccin-Mocha-Dark";
  };
}