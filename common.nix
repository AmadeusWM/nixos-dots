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
    dict
    eww
    gnome.dconf-editor # to find gnome keybinds
    gnome.gnome-tweaks
    gnome.nautilus
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
    xorg.xkill

    # FONTS
    minecraftia
    fira-code
    nerdfonts

    # ICONS
    papirus-icon-theme
  ];

  # Font for bar
  fonts = {
    fontconfig = {
      enable = true;      
    };
  };
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # home.pointerCursor = {
  #   package = pkgs.capitaine-cursors;
  #   name = "capitaine-cursors";
  #   gtk.enable = true;
  #   x11.enable = true;
  #   size = 24;
  # };
  # home.pointerCursor = 
  #   let 
  #     getFrom = url: hash: name: {
  #         gtk.enable = true;
  #         x11.enable = true;
  #         name = name;
  #         size = 26;
  #         package = 
  #           pkgs.runCommand "moveUp" {} ''
  #             mkdir -p $out/share/icons
  #             ln -s ${pkgs.fetchzip {
  #               url = url;
  #               hash = hash;
  #             }}/src/cursors/dist $out/share/icons/${name}
  #         '';
  #       };
  #   in
  #     getFrom 
  #       "https://github.com/vinceliuice/Qogir-icon-theme/archive/refs/tags/2023-06-05.tar.gz"
  #       "sha256-qiHmA/K4hdXVSFzergGhgssKR+kXp3X0cqtX1X5ayM4="
  #       "Qogir";
  # home.pointerCursor = 
  #   let 
  #     getFrom = url: hash: name: {
  #         gtk.enable = true;
  #         x11.enable = true;
  #         name = name;
  #         size = 24;
  #         package = 
  #           pkgs.runCommand "moveUp" {} ''
  #             mkdir -p $out/share/icons
  #             ln -s ${pkgs.fetchzip {
  #               url = url;
  #               hash = hash;
  #               stripRoot = false;
  #             }}/pixelfun2 $out/share/icons/${name}
  #         '';
  #       };
  #   in
  #     getFrom 
  #       "sha256-ML3fKJgb90rjPOOpcz+FuGtudgUqGnHOVYX/zdvckF8=https://git.sr.ht/~ainola/pixelfun2/refs/download/v6/pixelfun2-v6.tar.gz"
  #       "sha256-ML3fKJgb90rjPOOpcz+FuGtudgUqGnHOVYX/zdvckF8="
  #       "pixelfun2";
}
