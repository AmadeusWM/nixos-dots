{ config, pkgs, ... }:

{
  # todo: remove this, insecure!
  nixpkgs.config.permittedInsecurePackages = [
    "freeimage-unstable-2021-11-01"
  ];
  home.packages = with pkgs; [
    arandr
    deepin.deepin-screen-recorder # Screenrecord
    feh
    flameshot # Screenshots
    gcolor3
    rofi
    xclip
    xcolor
    xidlehook
  ];
}
