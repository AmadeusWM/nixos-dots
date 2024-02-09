{ pkgs, config, ... }:
{
  imports = [
    ./graphical
    ./terminal
    ./services
    ./themes
  ];

  
  home.packages = with pkgs; [
    acpi # check battery
    bluez
    chromium
    dict
    eww
    gnome.dconf-editor # to find gnome keybinds
    gnome.gnome-tweaks
    gnome.nautilus nautilus-open-any-terminal # nautilus + open different terminals with nautilus
    gnome.zenity
    jq # JSON parsing
    killall
    kitty
    libnotify
    niv # Dependency management for nix projects (fix npm bug)
    pamixer
    pavucontrol
    playerctl
    rm-improved # rip: alternative to rm (https://github.com/nivekuil/rip)
    vscode
    xorg.xkill

    # FONTS
    nerdfonts
    minecraftia

    # ICONS
    papirus-icon-theme
  ];

  # Font for bar
  fonts = {
    fontconfig = {
      enable = true;
    };
  };
}
