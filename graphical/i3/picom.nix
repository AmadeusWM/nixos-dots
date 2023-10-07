{ pkgs, config, ... }:
{
    services.picom = {
        enable = true;
        vSync = false;
    };
}