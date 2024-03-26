{ pkgs, ... }:
let 
  hyprPath = "~/nixos/modules/home-manager-modules/graphical/hyprland";
in
{
  wayland.windowManager.hyprland.extraConfig = ''
    bind=CAPS,Caps_Lock,exec,ags -r "capsLock.value = !capsLock.value"
    
    # example binds
    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    bind=SUPERALT,T,exec,notify-send "$(date '+%T')"

    # basic keybinds
    bind=SUPER,Q,killactive,
    bind=SUPERCTRL,Q,exec,${hyprPath}/config/scripts/tools/wkill.sh
    bind=SUPERCTRL,M,exit,
    bind=SUPERALT_L,M,exec,${hyprPath}/config/scripts/quick_reboot.sh
    bind=SUPER,S,togglefloating,
    bind=SUPERCTRL,D,pin
    bind=SUPER,space,exec,anyrun
    bind=SUPERCTRL,S,pseudo,
    bind=SUPER,D,exec,export NO_AT_BRIDGE=1; python3 ${hyprPath}/config/scripts/tools/dict.py

    # Screenshotting
    bind=,Print,exec,${hyprPath}/config/scripts/screenshot selection
    bind=CTRL,Print,exec,${hyprPath}/config/scripts/screenshot full_screen
    bind=ALT,Print,exec,${hyprPath}/config/scripts/screenshot delay
    bind=SUPER,Print,exec,${hyprPath}/config/scripts/record_screen

    # basic applications
    bind=SUPER,E,exec,nautilus
    bind=SUPERCTRL,N,exec,XDG_CURRENT_DESKTOP=GNOME gnome-control-center wifi

    # Kitty
    bind=CTRLALT_L,T,exec,kitty --single-instance
    bind=SUPER,T,exec,kitty --single-instance
    # Tools
    # bind=SUPER,V,exec,cliphist list | anyrun | cliphist decode | wl-copy
    bind=SUPER,V,exec,hyprctl dispatch exec '[float] copyq toggle'


    # running personal applications
    bind=CTRLALT_L,F,exec,firefox
    bind=SUPER,F,exec,firefox
    bind=SUPER,A,exec,hyprctl dispatch fullscreen 1
    bind=SUPERCTRL,A,exec,hyprctl dispatch fullscreen 2
    bind=SUPERALT,A,exec,hyprctl dispatch fakefullscreen
    bind=SUPER,O,exec,obsidian
    bind=SUPERCTRL,O,exec,obs --minimize-to-tray
    bind=SUPER,W,exec,code
    bind=SUPER,period,exec,emote
    bind=SUPER,P,exec,hyprctl dispatch exec '[float] nwg-displays -m ${hyprPath}/config/conf/monitors.conf'

    # lock screen
    bind=SUPERCTRLALTSHIFT,l,exec,${hyprPath}/config/scripts/lock

    # ease of life
    # Color picker
    bind=SUPER,C,exec,hyprpicker | wl-copy -n && notify-send --icon ~/nixos/modules/home-manager-modules/graphical/hyprland/themes/winter/eww/assets/snowflake2.png -t 4000 "$(wl-paste)"
    bind=SUPERCTRL,C,exec,hyprpicker | cut -c 2-7 | wl-copy -n && notify-send --icon ~/nixos/modules/home-manager-modules/graphical/hyprland/themes/winter/eww/assets/snowflake2.png -t 4000 "$(wl-paste)"

    bind=SUPER,U,exec,pkill -f '.*GradleDaemon.*'
    
    # Wallpaper
    bind=SUPER,B,exec,${hyprPath}/config/scripts/wallpaper/wallpaper_picker

    # binds for workspaces ##
    # focusing windows
    bind=SUPER,left,movefocus,l
    bind=SUPER,right,movefocus,r
    bind=SUPER,up,movefocus,u
    bind=SUPER,down,movefocus,d

    # moving windows
    bind=SUPERCTRL,left,movewindow,l
    bind=SUPERCTRL,right,movewindow,r
    bind=SUPERCTRL,up,movewindow,u
    bind=SUPERCTRL,down,movewindow,d

    # swapping windows
    bind=SUPERCTRLSHIFT,left,swapwindow,l
    bind=SUPERCTRLSHIFT,right,swapwindow,r
    bind=SUPERCTRLSHIFT,up,swapwindow,u
    bind=SUPERCTRLSHIFT,down,swapwindow,d
    
    # move windows into/out of group
    bind=SUPERALT,left,movewindoworgroup,l
    bind=SUPERALT,right,movewindoworgroup,r
    bind=SUPERALT,up,movewindoworgroup,u
    bind=SUPERALT,down,movewindoworgroup,d

    # swap between horizontal/vertical splitting
    bind=SUPER,z,layoutmsg,togglesplit

    # resizing
    binde=SUPERSHIFT,left,exec,  hyprctl dispatch resizeactive -200 0  # left
    binde=SUPERSHIFT,right,exec, hyprctl dispatch resizeactive  200 0  # right
    binde=SUPERSHIFT,up,exec,    hyprctl dispatch resizeactive  0 -200  # up
    binde=SUPERSHIFT,down,exec,  hyprctl dispatch resizeactive  0  200  # down
    # moving floating windows
    binde=SUPERCTRLSHIFT,left,exec,  hyprctl dispatch moveactive -200 0  # left
    binde=SUPERCTRLSHIFT,right,exec, hyprctl dispatch moveactive  200 0  # right
    binde=SUPERCTRLSHIFT,up,exec,    hyprctl dispatch moveactive  0 -200  # up
    binde=SUPERCTRLSHIFT,down,exec,  hyprctl dispatch moveactive  0  200  # down
    
    
    # moving to other wokspace with mouse control
    bind=SUPER,mouse_down,workspace,e-1
    bind=SUPER,mouse_up,workspace,e+1

    # group control
    bind=SUPER,g,togglegroup
    bind=SUPER,tab,changegroupactive
    bind=SUPERALT,g,moveoutofgroup
    bind=SUPER,l,lockactivegroup,toggle

    # kitty binds
    bind=SUPERCTRL,1,exec,kitty --title fly_is_kitty --hold cava
    bind=SUPERCTRL,2,exec,code-insiders
    bind=SUPERCTRL,3,exec,kitty --single-instance --hold donut.c
    bind=SUPERCTRL,4,exec,kitty --title clock_is_kitty --hold tty-clock -C5

    # Audio
    bind=,XF86AudioPlay,exec,playerctl play-pause
    bind=,XF86AudioPrev,exec,playerctl previous
    bind=,XF86AudioNext,exec,playerctl next

    bindl=,XF86AudioMedia,exec,playerctl play-pause
    bindl=,XF86AudioStop,exec,playerctl stop

    bindle=,XF86AudioRaiseVolume,exec,~/nixos/modules/home-manager-modules/services/dunst/scripts/volume/volume.sh up
    bindle=,XF86AudioLowerVolume,exec,~/nixos/modules/home-manager-modules/services/dunst/scripts/volume/volume.sh down
    bindle=,XF86AudioMute,exec,~/nixos/modules/home-manager-modules/services/dunst/scripts/volume/volume.sh mute
    # brightness
    bindle=,XF86MonBrightnessUp,exec,~/nixos/modules/home-manager-modules/services/dunst/scripts/brightness/brightness.sh up
    bindle=,XF86MonBrightnessDown,exec,~/nixos/modules/home-manager-modules/services/dunst/scripts/brightness/brightness.sh down
    bind=,XF86Calculator,exec,qalculate

    # Lid open/close
    # trigger when the switch is toggled
    # bindl=,switch:Lid Switch,exec,swaylock -c000000
    # trigger when the switch is turning on
    bindl=,switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, 2560x1600, 0x0, 1"
    # trigger when the switch is turning off
    bindl=,switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"

    # workspaces
    # focusing other workspaces
    bind=SUPER,1,exec, ${hyprPath}/config/scripts/workspace visit 1
    bind=SUPER,2,exec, ${hyprPath}/config/scripts/workspace visit 2
    bind=SUPER,3,exec, ${hyprPath}/config/scripts/workspace visit 3
    bind=SUPER,4,exec, ${hyprPath}/config/scripts/workspace visit 4
    bind=SUPER,5,exec, ${hyprPath}/config/scripts/workspace visit 5
    bind=SUPER,6,exec, ${hyprPath}/config/scripts/workspace visit 6
    bind=SUPER,7,exec, ${hyprPath}/config/scripts/workspace visit 7
    bind=SUPER,8,exec, ${hyprPath}/config/scripts/workspace visit 8
    bind=SUPER,9,exec, ${hyprPath}/config/scripts/workspace visit 9
    bind=SUPER,0,exec, ${hyprPath}/config/scripts/workspace visit 10

    # focusing other workspaces
    # moving windows to other workspaces
    bind=ALT_L,1,exec, ${hyprPath}/config/scripts/workspace move 1
    bind=ALT_L,2,exec, ${hyprPath}/config/scripts/workspace move 2
    bind=ALT_L,3,exec, ${hyprPath}/config/scripts/workspace move 3
    bind=ALT_L,4,exec, ${hyprPath}/config/scripts/workspace move 4
    bind=ALT_L,5,exec, ${hyprPath}/config/scripts/workspace move 5
    bind=ALT_L,6,exec, ${hyprPath}/config/scripts/workspace move 6
    bind=ALT_L,7,exec, ${hyprPath}/config/scripts/workspace move 7
    bind=ALT_L,8,exec, ${hyprPath}/config/scripts/workspace move 8
    bind=ALT_L,9,exec, ${hyprPath}/config/scripts/workspace move 9
    bind=ALT_L,0,exec, ${hyprPath}/config/scripts/workspace move 10

    # moving windows to other workspaces (silent)
    bind=SUPERALT_L,1,exec, ${hyprPath}/config/scripts/workspace movesilent 1
    bind=SUPERALT_L,2,exec, ${hyprPath}/config/scripts/workspace movesilent 2
    bind=SUPERALT_L,3,exec, ${hyprPath}/config/scripts/workspace movesilent 3
    bind=SUPERALT_L,4,exec, ${hyprPath}/config/scripts/workspace movesilent 4
    bind=SUPERALT_L,5,exec, ${hyprPath}/config/scripts/workspace movesilent 5
    bind=SUPERALT_L,6,exec, ${hyprPath}/config/scripts/workspace movesilent 6
    bind=SUPERALT_L,7,exec, ${hyprPath}/config/scripts/workspace movesilent 7
    bind=SUPERALT_L,8,exec, ${hyprPath}/config/scripts/workspace movesilent 8
    bind=SUPERALT_L,9,exec, ${hyprPath}/config/scripts/workspace movesilent 9
    bind=SUPERALT_L,0,exec, ${hyprPath}/config/scripts/workspace movesilent 10

    # # laptop display
    workspace = 1, monitor:eDP-1
    workspace = 2, monitor:eDP-1
    workspace = 3, monitor:eDP-1
    workspace = 4, monitor:eDP-1
    workspace = 5, monitor:eDP-1
    workspace = 6, monitor:eDP-1
    workspace = 7, monitor:eDP-1
    workspace = 8, monitor:eDP-1
    workspace = 9, monitor:eDP-1
    workspace = 10, monitor:eDP-1

    # # display port
    workspace = 11, monitor:DP-1
    workspace = 12, monitor:DP-1
    workspace = 13, monitor:DP-1
    workspace = 14, monitor:DP-1
    workspace = 15, monitor:DP-1
    workspace = 16, monitor:DP-1
    workspace = 17, monitor:DP-1
    workspace = 18, monitor:DP-1
    workspace = 19, monitor:DP-1
    workspace = 20, monitor:DP-1

    # # HDMI
    workspace = 21, monitor:HDMI-A-1
    workspace = 22, monitor:HDMI-A-1
    workspace = 23, monitor:HDMI-A-1
    workspace = 24, monitor:HDMI-A-1
    workspace = 25, monitor:HDMI-A-1
    workspace = 26, monitor:HDMI-A-1
    workspace = 27, monitor:HDMI-A-1
    workspace = 28, monitor:HDMI-A-1
    workspace = 29, monitor:HDMI-A-1
    workspace = 30, monitor:HDMI-A-1
  '';
}
