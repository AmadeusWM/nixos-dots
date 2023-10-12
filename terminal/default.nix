{ pkgs, config, ... }:
{
  imports = [
    ./zsh
    ./kitty
    ./starship
    ./nvim
  ];
}