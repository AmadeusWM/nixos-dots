{ pkgs, config, ... }:
{
  imports = [
    ./copyq
    ./firefox
    ./vscode
    ./zathura
  ];
}