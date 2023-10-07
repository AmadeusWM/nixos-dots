{ config, pkgs, ... }:

{ 
  home.packages = with pkgs; [
    cliphist
    dart-sass
    gtklock
    grim # Screenshots
    hyprpicker
    networkmanagerapplet
    socat
    slurp # Screencoordinates for selected area
    swappy # Screenshot editor
    swaylock
    swayidle
    swww
    wdisplays
    wf-recorder
    wl-clip-persist
    wl-clipboard
    wofi
    xorg.xhost # fix gparted not starting (and perhaps other apps aswell)
  ];
}
