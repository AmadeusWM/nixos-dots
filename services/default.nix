{ pkgs, config, ... }:
{
  imports = [
    ./dunst
    # Wayland:
    ./swayidle
    ./gtklock
  ];
}
