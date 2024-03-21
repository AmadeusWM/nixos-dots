{ config, pkgs, ... }:

{ 
  home.packages = with pkgs; [
    cliphist
    dart-sass
    gnome.gnome-bluetooth
    gtklock
    grim # Screenshots
    hyprpaper
    hyprpicker
    networkmanagerapplet
    socat
    slurp # Screencoordinates for selected area
    swappy # Screenshot editor
    swaylock
    # swayidle
    swww
    wdisplays
    wf-recorder
    wl-clip-persist
    wl-clipboard
    wofi
    xorg.xhost # fix gparted not starting (and perhaps other apps aswell)
  ];

  services.copyq.enable = true; 
}
