{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    arandr
    feh
    flameshot # Screenshots
    gcolor3
    rofi
    xclip
    xcolor
    xidlehook
  ];
}
