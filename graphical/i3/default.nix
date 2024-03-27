{ pkgs, config, ... }:
{
  imports = [
    ./config
    ./picom.nix
    ./dependencies.nix
  ];
}
