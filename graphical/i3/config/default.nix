{ pkgs, config, ... }:
{
  imports = [
    ./config.nix
    ./scripts/record.nix
  ];
}
