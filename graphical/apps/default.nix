{ pkgs, config, ... }:
{
  imports = [
    ./firefox
    ./vscode
    ./copyq
  ];
}