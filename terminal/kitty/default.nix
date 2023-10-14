{ pkgs, config, ... }:
{
  programs.kitty = {
    enable = true;
    # settings = import ./settings.nix;
    settings = import ./catppuccin.nix;
    keybindings = {
      "ctrl+shift+left" =  "no_op";
      "ctrl+shift+right" =  "no_op";
      "ctrl+shift+home" =  "no_op";
      "ctrl+shift+end" =  "no_op";
      "ctrl+shift+return" =  "no_op";
    };
  };
}