{ config, pkgs, inputs, ...}:

{
  imports = [
    ./config
    ./dependencies.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
  };

  home.packages = [
    inputs.hypridle.packages."x86_64-linux".default
    inputs.hyprlock.packages."x86_64-linux".default
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/Pictures/wallpapers/wallpapers/widescreen/spirit_dark_blue.png
    wallpaper = ,~/Pictures/wallpapers/wallpapers/widescreen/spirit_dark_blue.png
  '';
  
  xdg.configFile."hypr/hypridle.conf".text = ''
    $lock_cmd = pidof hyprlock || hyprlock
    $suspend_cmd = systemctl suspend
    $suspend_when_locked_cmd = pidof hyprlock && systemctl suspend

    general {
        # lock_cmd = $lock_cmd
        # unlock_cmd 
        # before_sleep_cmd = $lock_cmd
        # after_sleep_cmd 
    }

    # listener {
    #     timeout = 900
    #     on-timeout = $lock_cmd
    #     # on-resume = 
    # }

    listener {
        timeout = 960
        on-timeout = $suspend_cmd
        # on-resume
    }

    # listener {
    #     timeout = 60
    #     on-timeout = $suspend_when_locked_cmd
    # }
  '';
  
  xdg.configFile."hypr/hyprlock.conf".text = ''
    $text_color = rgba(eae0e4FF)
    $entry_background_color = rgba(120F1111)
    $entry_border_color = rgba(9a8d9555)
    $entry_color = rgba(d1c2cbFF)
    $font_family = Gabarito
    $font_family_clock = Gabarito
    $font_material_symbols = Material Symbols Rounded
    $monitor = eDP-1

    background {
        monitor = $monitor
        color = rgba(120F1177)
        # path = {{ SWWW_WALL }}
        path = screenshot
        blur_size = 5
        blur_passes = 4
    }
    input-field {
        monitor = $monitor
        size = 250, 50
        outline_thickness = 2
        dots_size = 0.1
        dots_spacing = 0.3
        outer_color = $entry_border_color
        inner_color = $entry_background_color
        font_color = $entry_color
        # fade_on_empty = true

        position = 0, 20
        halign = center
        valign = center
    }

    label { # Clock
        monitor = $monitor
        text = $TIME
        color = $text_color
        font_size = 65
        font_family = $font_family_clock

        position = 0, 300
        halign = center
        valign = center
    }
    label {
        monitor = $monitor
        text = hi $USER !!!
        color = $text_color
        font_size = 20
        font_family = $font_family

        position = 0, 240
        halign = center
        valign = center
    }
    label {
        monitor = $monitor
        text = lock
        color = $text_color
        font_size = 21
        font_family = $font_material_symbols

        position = 0, 65
        halign = center
        valign = bottom
    }
    label {
        monitor = $monitor
        text = locked
        color = $text_color
        font_size = 14
        font_family = $font_family

        position = 0, 50
        halign = center
        valign = bottom
    }
  '';
}
