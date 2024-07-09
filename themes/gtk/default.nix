{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      glib # gsettings
      # (catppuccin-gtk.override {
      #   size = "standard";
      #   accents = ["blue"];
      #   variant = "mocha";
      #   tweaks = ["normal"];
      # })
      # (catppuccin-papirus-folders.override {
      #   accent = "blue";
      #   flavor = "mocha";
      # })
    ];
  };
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  
  # home.sessionVariables.GTK_THEME = "Catppuccin-Mocha-Standard-Pink-Dark";
  
  gtk = {
    enable = true;

    # theme = {
    #   name = "Catppuccin-Mocha-Standard-Pink-Dark";
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = [ "pink" ];
    #     size = "standard";
    #     tweaks = [ "normal" ];
    #     variant = "mocha";
    #   };
    # };
    # theme = {
    #   name = "Materia-dark";
    #   package = pkgs.materia-theme;
    # };

    theme = {
      name = "Dracula"; # this name has to be the same as the tar file u want (or something idk what im doing)
      package = pkgs.dracula-theme;
    };

    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.catppuccin-papirus-folders.override {
    #     accent = "blue";
    #     flavor = "mocha";
    #   };
    # };

    # font = {
    #   name = "Lexend";
    #   size = 13;
    # };
    
    gtk4.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 1;
      gtk-cursor-theme-name="Bibata-Modern-Classic";
    };

    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-application-prefer-dark-theme = 1;
      gtk-cursor-theme-name="Bibata-Modern-Classic";
    };

    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name="Bibata-Modern-Classic"
      '';
    };
  };
}
