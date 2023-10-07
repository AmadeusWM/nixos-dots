{ pkgs, config, ... }:
{
  imports = [
    ./config
    ./picom.nix
  ];
}