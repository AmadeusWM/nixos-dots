{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    feh
    flameshot # Screenshots
    gcolor3
    rofi
    xclip
  ];
}
