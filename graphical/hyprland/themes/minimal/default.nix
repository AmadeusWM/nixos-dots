{ pkgs, config, ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    general {
      border_size=2
      col.active_border=0xffA8C5E6
      col.inactive_border=0xFF0C0B10

      gaps_in=2
      gaps_out=4
    }

    decoration {
      rounding=4

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
      bezier=normal,0.13,0.99,0.29,1.0
      animation=windows,1,1,normal,slide
      animation=border,1,2,default
      animation=fade,1,2,default
      animation=workspaces,1,1,default,slide
    }

    # binds
    bind=SUPERSHIFT,B,exec, ~/nixos-dotfiles/home/dots/graphical/hyprland/themes/minimal/waybar/waybar.sh

    # startup
    exec=~/nixos-dotfiles/home/dots/graphical/hyprland/themes/minimal/waybar/waybar.sh
  '';
}