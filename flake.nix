{
  description = "A very basic flake";

  outputs = inputs: {
    # all common components
    common = ./common.nix;

    themes = ./themes;
    terminal = ./terminal;

    # compositor's, wm's, de's
    hyprland = {
      hyprland = ./graphical/hyprland/default.nix;
      keybindsQwerty = ./graphical/hyprland/config/keybinds.nix;
      monitors = ./graphical/hyprland/config/monitors.nix;
      themes = {
        comic = ./graphical/hyprland/themes/comic;
        poeisis = ./graphical/hyprland/themes/poeisis;
        minimalism = ./graphical/hyprland/themes/comic;
      };
    };
    
    i3 = {
      i3 = ./graphical/i3/default.nix;
    };

    gnome = ./graphical/gnome/default.nix;

    # apps
    firefox = ./graphical/apps/firefox;
    vscode = ./graphical/apps/vscode;

    # launchers
    wofi = ./launchers/wofi;
    
    # services
    dunst = ./services/dunst;
    gtklock = ./services/gtklock;
    swayidle = ./services/gtklock;
  };
}
