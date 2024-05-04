{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    arandr
    feh
    flameshot # Screenshots
    gcolor3
    rofi
    smile # emoji picker
    xclip
    xcolor
    xidlehook
  ];
}
