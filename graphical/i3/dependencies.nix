{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    deepin.deepin-screen-recorder # Screenrecord
    feh
    flameshot # Screenshots
    gcolor3
    rofi
    xclip
    xcolor
  ];
}