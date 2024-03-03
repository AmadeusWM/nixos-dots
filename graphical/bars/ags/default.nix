{ inputs, pkgs, config, ... }:
{
  # add the home manager module
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;
    
    # null or path, leave as null if you don't want hm to manage the config
    configDir = ./typescript_bar;

    # packages to add to gjs's runtime
    extraPackages = [ pkgs.libsoup_3 ]; 
  };
  home.packages = with pkgs; [
    sassc
    brightnessctl
  ];
  
  wayland.windowManager.hyprland.extraConfig = ''
    bind=SUPERSHIFT,semicolon,exec, ags --toggle-window command-runner
  '';
}
