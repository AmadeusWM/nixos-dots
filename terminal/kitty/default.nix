{ pkgs, config, ... }:
{
  programs.kitty = {
    enable = true;
    # settings = import ./settings.nix;
    settings = import ./catppuccin.nix;
    keybindings = {
      "ctrl+shift+return" =  "no_op"; # we want to use this for new line in helix
      "ctrl+return"  =  "no_op"; # we want to use this for new line in helix
      "ctrl+shift+n" = "launch --cwd=current --location=hsplit";
      "ctrl+alt+n"   = "launch --cwd=current --location=vsplit";
      "ctrl+shift+q" = "close_window";
      # focus
      "ctrl+shift+left"  = "neighboring_window left";
      "ctrl+shift+right" = "neighboring_window right";
      "ctrl+shift+up"    = "neighboring_window up";
      "ctrl+shift+down"  = "neighboring_window down";
      # move
      "ctrl+shift+alt+left"  = "move_window left";
      "ctrl+shift+alt+right" = "move_window right";
      "ctrl+shift+alt+up"    = "move_window up";
      "ctrl+shift+alt+down"  = "move_window down";
      # resize
      "ctrl+alt+left"  = "resize_window narrower 10";
      "ctrl+alt+right" = "resize_window wider 10";
      "ctrl+alt+up"    = "resize_window taller 10";
      "ctrl+alt+down"  = "resize_window shorter 10";
    };
  };
}
