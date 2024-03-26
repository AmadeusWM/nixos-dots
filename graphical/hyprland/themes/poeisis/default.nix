{ pkgs, config, ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    general {
        border_size=1
        col.active_border=rgba(A8C5E6ff) rgba(f1a7e2ff) 45deg
        col.inactive_border=0xff0B0A10

        gaps_in=0
        gaps_out=0
    }

    decoration {
        rounding=0
        blur {
          size=8
          passes=3
          new_optimizations=1
        }

        drop_shadow=1
        shadow_range=15
        shadow_render_power=2
        shadow_ignore_window=1
        shadow_offset= 0 4
        col.shadow=0x55000000
        col.shadow_inactive=0x55000000
    }

    misc {
        animate_mouse_windowdragging=false # this fixes the laggy window movement (source: https://github.com/hyprwm/Hyprland/issues/1753)
    }

    animations {
        # Flick0's animations
        enabled=1
        # bezier=overshot,0.05,0.9,0.1,1.1
        bezier=overshot,0.13,0.99,0.29,1.10
        animation=windows,1,0.5,default,slide
        animation=border,0,0.5,default
        animation=fade,1,0.5,default
        animation=workspaces,1,0.5,default,slide
    }

    layerrule=blur,waybar
    layerrule=blur,notifications
    layerrule=ignorezero,notifications

    bind=SUPERSHIFT,B,exec, ~/nixos/modules/home-manager-modules/graphical/hyprland/themes/poeisis/waybar/waybar.sh

    exec=~/nixos/modules/home-manager-modules/graphical/hyprland/themes/poeisis/waybar/waybar.sh
  '';
}