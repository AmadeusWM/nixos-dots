{
  mainBar = {
    layer= "top";
    position = "bottom";
    height =  20;
    modules-left =  [
        "hyprland/workspaces"
    ];
    modules-center =  [
        # "hyprland/window"
    ];
    modules-right =  [
        "tray"
        "backlight"
        "custom/sep" 
        "pulseaudio"
        "custom/sep" 
        "bluetooth"
        "custom/sep" 
        "network"
        "custom/sep" 
        "battery"
        "custom/sep" 
        "clock"
    ];
    "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        sort-by-number = true;
        format-icons = {
            "1" = "I";
            "2" = "II";
            "3" = "III";
            "4" = "IV";
            "5" = "V";
            "6" = "VI";
            "7" = "VII";
            "8" = "VIII";
            "9" = "IX";
            "10" = "X";
            "11" = "XI";
            "12" = "XII";
            "13" = "XIII";
            "14" = "XIV";
            "15" = "XV";
            "16" = "XVI";
            "17" = "XVII";
            "18" = "XVIII";
            "19" = "XIX";
            "21" = "XXI";
            "22" = "XXII";
            "23" = "XXIII";
            "24" = "XXIV";
            "25" = "XXV";
            "26" = "XXVI";
            "27" = "XXVII";
            "28" = "XXVIII";
            "29" = "XXIX";
            "30" = "XXX";
            "urgent" = "";
        };
    };
    clock = {
        interval = 1;
        format = ''{:%Y/%d/%m %H:%M:%S}'';
        "on-click" = "morgen";
    };
    battery = {
        format = "{capacity}%";
        format-alt = "{time} {icon} ";
        format-charging = "CHR {capacity}%";
        interval = 30;
        states = {
            warning = 25;
            critical = 10;
        };
        tooltip-format = "At {capacity}%";
    };
    network = {
        format = "{ipaddr} ({essid})";
        format-wifi = "W: {ipaddr} ({essid})";
        format-ethernet = "E: {ipaddr}";
        format-disconnected = "W/E: down";
        format-disabled = "W/E: down";
        format-alt = "W/E: {ipaddr} {bandwidthDownBytes}";
        format-alt-click = "click-right";
        interval = 5;
        on-click = "hyprctl dispatch exec '[float] XDG_CURRENT_DESKTOP=GNOME gnome-control-center wifi'";
        tooltip-format = "{ipaddr}/{cidr}";
    };
    bluetooth = {	
        "format" = "BT: {status}";
        "format-disabled" = "BT: down";
        "format-connected" = "BT: {num_connections} connected";
        "tooltip-format" = "{controller_alias}\t{controller_address}";
        "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
        "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
        "on-click" = "hyprctl dispatch exec '[float] blueman-manager'";
    };
    pulseaudio = {
        format = "SND {volume}%";
        format-muted = "SND: 0%";
        scroll-step = 10;
        on-click = "pavucontrol";
        tooltip-format = "At {volume}%";
    };
    backlight = {
        format = "LHT: {percent}%";
        format-alt-click = "click-right";
        on-scroll-down = "light -U 10";
        on-scroll-up = "light -A 10";
    };
    tray = {
        icon-size = 18;
        spacing = 10;
    };
    "custom/dunst" = {
        format = "{}";
        exec = "~/nixos/modules/home-manager-modules/graphical/hyprland/themes/comic/waybar/modules/dunst.sh";
        on-click = "dunstctl set-paused toggle";
        restart-interval = 1;
    };
    "custom/sep" = {
        format = "|";
    };
  };
}
