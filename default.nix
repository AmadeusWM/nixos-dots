{ pkgs, config, ... }:
{
  imports = [
    ./graphical
    ./terminal
    ./services
    ./themes
  ];
}