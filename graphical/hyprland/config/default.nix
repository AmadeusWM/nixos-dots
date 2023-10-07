{ pkgs, lib, config, ... }:
{
  imports = [
    ./general.nix
    ./envs.nix
  ];
}