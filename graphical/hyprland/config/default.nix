{ pkgs, lib, config, ... }:
{
  imports = [
    ./general.nix
    ./envs.nix
    ./keybinds.nix
    ./monitors.nix
  ];
}