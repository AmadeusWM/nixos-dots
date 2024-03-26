{ pkgs, ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    exec-once=$HOME/nixos/modules/home-manager-modules/graphical/hyprland/config/scripts/startup/autostart
    exec-once=copyq --start-server 

    exec-once=hyprctl setcursor Sunity-cursors 24
    env=XCURSOR_THEME, Sunity-cursors 24
    env=DOWNGRADE_FROM_ALA,1
    # env=QT_STYLE_OVERRIDE,kvantum

    exec-once=$HOME/nixos/modules/home-manager-modules/graphical/hyprland/config/scripts/idle_handler.sh

    # plugin {
    #     hyprwinwrap {
    #         # class is an EXACT match and NOT a regex!
    #         class = kitty-bg
    #     }
    # }

    input {
        kb_layout=
        kb_variant=ffffff
        kb_model=
        kb_options=compose:rctrl,level3:ralt_switch
        # kb_options = caps:swapescape # fuck it, we ball. nvm, let's do this in kmonad bby
        kb_rules=

        follow_mouse=1

        touchpad {
            natural_scroll=yes
            disable_while_typing=yes
            scroll_factor=1
        }
        repeat_delay=250 # time between key registers when holding down
    }

    misc {
        disable_hyprland_logo=true
        animate_mouse_windowdragging=false # this fixes the laggy window movement (source: https://github.com/hyprwm/Hyprland/issues/1753)
        animate_manual_resizes=false # fixes slow resizes
    }

    general {
        #sensitivity=1.0 # for mouse cursor
        # col.active_border=0xfff5c2e7
        # col.inactive_border=0xff45475a
        # apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
    }

    decoration {
        # screen_shader=~/nixos/modules/home-manager-modules/graphical/hyprland/shaders/crt.frag
        blur {
            enabled=true
            new_optimizations = on
            size=1 # minimum 1
            passes=2 # minimum 1, more passes = more resource intensive.
            # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
            # if you want heavy blur, you need to up the blur_passes.
            # the more passes, the more you can up the blur_size without noticing artifacts.
        }
    }

    group {
        col.border_active=0xffCBA6F7
        col.border_inactive=0xff0B0A10
        col.border_locked_active = 0xffF38BA8
        col.border_locked_inactive = 0xffC35B78
        groupbar {
            enabled=true
            col.active = 0x99CBA6F7
            col.inactive = 0x99816a9c
            col.locked_active = 0x99F38BA8
            col.locked_inactive = 0x99C35B78
        }
    }

    dwindle {
        pseudotile=1 # enable pseudotiling on dwindle
        smart_split=1
    }

    master{
        
    }

    gestures {
        workspace_swipe=yes
        workspace_swipe_fingers=4
    }

    # other
    # floating windows
    windowrule=float,^(nm-connection-editor)$
    windowrule=float,^(copyq)$
    windowrule=float,^(zenity)$
    windowrule=float,title:^(New Text Note — Okular)$
    windowrule=float,title:^(org.gnome.Nautilus New Folder)$
    # firefox sharing indicator
    # windowrule=nofullscreenrequest,title:^(Firefox — Sharing Indicator)$
    windowrule=float,title:^(Firefox — Sharing Indicator)$
    windowrule=move 100%-470 15,title:^(Firefox — Sharing Indicator)$
    # idle inhibit when watching videos
    windowrulev2 = idleinhibit focus, class:^(mpv|.+exe)$
    windowrulev2 = idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$
    windowrulev2 = idleinhibit fullscreen, class:^(firefox)$
  '';
}
