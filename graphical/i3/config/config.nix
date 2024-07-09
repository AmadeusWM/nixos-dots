{ config, lib, pkgs, ... }:
let 
  mod = "Mod4";
  alt = "Mod1";
  workspace = "~/nixos/modules/home-manager-modules/graphical/i3/config/scripts/workspace.sh";
in {
  home.packages = with pkgs; [
    i3status
    i3blocks
  ];
  xsession.windowManager.i3 = {
    enable = true;

    extraConfig = ''
    # see https://i3wm.org/docs/userguide.html#client_colors
    # class                 border  backgr. text    indicator child_border
    
    '';
    config = {
      modifier = mod;

      terminal = "kitty";
      colors = {
        focused = {
          border =      "#b4befe";
          background =  "#b4befe"; 
          text =        "#11111b";
          indicator =   "#89b4fa";
          childBorder = "#b4befe";
        };
        # e.g. focused window from another screen, or inside another branch
        focusedInactive = {
          border =      "#1e1e2e";
          background =  "#1e1e2e"; 
          text =        "#ffffff";
          indicator =   "#373757";
          childBorder = "#1e1e2e";
        };
        unfocused = {
          border =      "#181825";
          background =  "#181825"; 
          text =        "#888888";
          indicator =   "#32324d";
          childBorder = "#181825";
        };
      };
      bars = [
        {
          statusCommand = "i3status";
          # statusCommand = "i3blocks";
          mode = "hide";
          position = "bottom";
          colors = {
            background = "#0f0f17";
            statusline = "#ffffff";
            separator =  "#11111b";
            focusedWorkspace  = {
              background = "#b4befe"; 
              border = "#181825"; 
              text = "#11111b";
            };
            activeWorkspace   = {
              background = "#b4befe"; 
              border = "#181825"; 
              text = "#11111b";
            };
            inactiveWorkspace = {
              background = "#313244"; 
              border = "#313244"; 
              text = "#888888";
            };
            urgentWorkspace = {
              background = "#2f343a"; 
              border = "#900000"; 
              text = "#ffffff";
            };
            bindingMode = {
              background = "#2f343a"; 
              border = "#900000"; 
              text = "#ffffff";
            };
          };
        }
      ];
      window = {
        titlebar = true;
      };
      keybindings = {
        # Applications
        "${mod}+Control+m" = "exit";
        "${mod}+Control+n" = "exec XDG_CURRENT_DESKTOP=GNOME gnome-control-center wifi";
        "${mod}+m" = "exec morgen";
        "${mod}+t" = "exec wezterm";
        "${alt}+Control+t" = "exec wezterm";
        "${mod}+f" = "exec firefox";
        "${mod}+e" = "exec nautilus";
        "${mod}+w" = "exec code";
        "${mod}+o" = "exec obsidian";
        "${mod}+period" = "exec smile";
        
        # Screen capture
        "${mod}+space" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "Print" = "exec flameshot gui -c -p ~/Pictures/Screenshots";
        "${alt}+Print" = "exec flameshot gui -p ~/Pictures/Screenshots";
        "${mod}+Print" = "exec i3-record";
        "${mod}+Control+Shift+l" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 2 && systemctl suspend'";

        # tools
        "${mod}+d" = "exec python3 ~/nixos/modules/home-manager-modules/graphical/i3/config/scripts/tools/dict.py";
        "${mod}+p" = "exec arandr";
        "--release ${mod}+c" = "exec xcolor --selection clipboard";

        # i3 stuff
        "${mod}+q" = "kill";
        "--release ${mod}+Control+q" = "exec xkill"; # Doesn't work without `--release`
        "${mod}+a" = "fullscreen toggle";
        "${mod}+s" = "floating toggle";
        "${mod}+z" = "layout toggle split";
        "${mod}+v" = "splitv";
        "${mod}+h" = "splith";
        "${mod}+b" = "bar mode toggle";

        # Focus
        "${mod}+Left" =  "focus left";
        "${mod}+Down" =  "focus down";
        "${mod}+Up" =    "focus up";
        "${mod}+Right" = "focus right";

        # Move
        "${mod}+Control+Left" =  "move left";
        "${mod}+Control+Down" =  "move down";
        "${mod}+Control+Up" =    "move up";
        "${mod}+Control+Right" = "move right";
        
        # Resize Grow
        "${mod}+Shift+Left" =  "resize grow left  40 px or 3 ppt";
        "${mod}+Shift+Down" =  "resize grow down  40 px or 3 ppt";
        "${mod}+Shift+Up" =    "resize grow up    40 px or 3 ppt";
        "${mod}+Shift+Right" = "resize grow right 40 px or 3 ppt";

        # Resize Shrink
        "${mod}+Control+Shift+Left" =  "resize shrink right   40 px or 3 ppt";
        "${mod}+Control+Shift+Down" =  "resize shrink up      40 px or 3 ppt";
        "${mod}+Control+Shift+Up" =    "resize shrink down    40 px or 3 ppt";
        "${mod}+Control+Shift+Right" = "resize shrink left    40 px or 3 ppt";

        # switch to workspace
        "${mod}+1" = "exec ${workspace} visit 1";
        "${mod}+2" = "exec ${workspace} visit 2";
        "${mod}+3" = "exec ${workspace} visit 3";
        "${mod}+4" = "exec ${workspace} visit 4";
        "${mod}+5" = "exec ${workspace} visit 5";
        "${mod}+6" = "exec ${workspace} visit 6";
        "${mod}+7" = "exec ${workspace} visit 7";
        "${mod}+8" = "exec ${workspace} visit 8";
        "${mod}+9" = "exec ${workspace} visit 9";
        "${mod}+0" = "exec ${workspace} visit 0";

        # move focused container to workspace
        "${alt}+1" = "exec ${workspace} move 1";
        "${alt}+2" = "exec ${workspace} move 2";
        "${alt}+3" = "exec ${workspace} move 3";
        "${alt}+4" = "exec ${workspace} move 4";
        "${alt}+5" = "exec ${workspace} move 5";
        "${alt}+6" = "exec ${workspace} move 6";
        "${alt}+7" = "exec ${workspace} move 7";
        "${alt}+8" = "exec ${workspace} move 8";
        "${alt}+9" = "exec ${workspace} move 9";
        "${alt}+0" = "exec ${workspace} move 0";

        # move focused container silently
        "${mod}+${alt}+1" = "exec ${workspace} movesilent 1";
        "${mod}+${alt}+2" = "exec ${workspace} movesilent 2";
        "${mod}+${alt}+3" = "exec ${workspace} movesilent 3";
        "${mod}+${alt}+4" = "exec ${workspace} movesilent 4";
        "${mod}+${alt}+5" = "exec ${workspace} movesilent 5";
        "${mod}+${alt}+6" = "exec ${workspace} movesilent 6";
        "${mod}+${alt}+7" = "exec ${workspace} movesilent 7";
        "${mod}+${alt}+8" = "exec ${workspace} movesilent 8";
        "${mod}+${alt}+9" = "exec ${workspace} movesilent 9";
        "${mod}+${alt}+0" = "exec ${workspace} movesilent 0";

        # Audio
        "XF86AudioPlay" = "exec playerctl -p $(tail -1 /tmp/player-last) play-pause";
        "XF86AudioPrev" = "exec playerctl -p $(tail -1 /tmp/player-last) previous";
        "XF86AudioNext" = "exec playerctl -p $(tail -1 /tmp/player-last) next";

        "XF86AudioMedia" = "exec playerctl -p $(tail -1 /tmp/player-last) play-pause";
        "XF86AudioStop" = "exec playerctl -p $(tail -1 /tmp/player-last) stop";

        "XF86AudioRaiseVolume" = "exec ~/nixos/modules/home-manager-modules/services/dunst/scripts/volume up";
        "XF86AudioLowerVolume" = "exec ~/nixos/modules/home-manager-modules/services/dunst/scripts/volume down";
        "XF86AudioMute" = "exec ~/nixos/modules/home-manager-modules/services/dunst/scripts/volume mute";

        # brightness
        "XF86MonBrightnessUp" = "exec ~/nixos/modules/home-manager-modules/services/dunst/scripts/brightness up";
        "XF86MonBrightnessDown" = "exec ~/nixos/modules/home-manager-modules/services/dunst/scripts/brightness down";

        # System Shortcuts
        "XF86Calculator" = "exec kitty qalc";
      };
      startup = [
          {
            command = "setxkbmap -option compose:caps";
            always = true;
            notification = false;
          }
          # Set refreshrate WideScreen
          {
            command = "sleep 1 && xrandr --output DP-3 --rate 74.98 --mode 3440x1440 --dpi 96";
            # command = "xrandr --output DisplayPort-0 --rate 74.98 --mode 3440x1440";
            always = true;
            notification = false;
          }
          # feh wallpaper
          {
            command = "sleep 2 && feh --bg-center /home/amadeusw/Pictures/wallpapers/free_zenneh_images.png";
            always = false;
            notification = false;
          }
          # follow last player (src: https://github.com/altdesktop/playerctl/issues/128)
          {
            # saves latest player name to /tmp/player-last
            command = "playerctl status --format '{{ playerName }}' --follow > /tmp/player-last";
            always = false;
            notification = false;
          } 
          # Key repeat delay (src: https://jaketrent.com/post/adjust-keyboard-repeat-rate-i3/)
          {
            command = "xset r rate 250 35";
            always = false;
            notification = false;
          }
          # Lock and hibernate after a while
          # {
          #   command = "xidlehook --detect-sleep --not-when-audio --not-when-fullscreen --timer 600 'systemctl hibernate' ''";
          #   always = false;
          #   notification = false;
          # }
          {
            command = "xidlehook --detect-sleep --not-when-audio --not-when-fullscreen --timer 600 'xset dpms force off' 'xset dpms force on'";
            always = false;
            notification = false;
          }
          # Automatically use layout generated by arandr
          {
            command = ".screenlayout/layout.sh";
            always = false;
            notification = false;
          }
      ];
      # Assign Workspaces to Screens
      # i3-msg -t get_outputs
      workspaceOutputAssign = [
        # With Nvidia
        { output = "DP-0"; workspace = "1"; }
        { output = "DP-0"; workspace = "2"; }
        { output = "DP-0"; workspace = "3"; }
        { output = "DP-0"; workspace = "4"; }
        { output = "DP-0"; workspace = "5"; }
        { output = "DP-0"; workspace = "6"; }
        { output = "DP-0"; workspace = "7"; }
        { output = "DP-0"; workspace = "8"; }
        { output = "DP-0"; workspace = "9"; }
        { output = "DP-0"; workspace = "0"; }

        { output = "DP-3"; workspace = "11"; }
        { output = "DP-3"; workspace = "12"; }
        { output = "DP-3"; workspace = "13"; }
        { output = "DP-3"; workspace = "14"; }
        { output = "DP-3"; workspace = "15"; }
        { output = "DP-3"; workspace = "16"; }
        { output = "DP-3"; workspace = "17"; }
        { output = "DP-3"; workspace = "18"; }
        { output = "DP-3"; workspace = "19"; }
        { output = "DP-3"; workspace = "10"; }

        { output = "HDMI-0"; workspace = "21"; }
        { output = "HDMI-0"; workspace = "22"; }
        { output = "HDMI-0"; workspace = "23"; }
        { output = "HDMI-0"; workspace = "24"; }
        { output = "HDMI-0"; workspace = "25"; }
        { output = "HDMI-0"; workspace = "26"; }
        { output = "HDMI-0"; workspace = "27"; }
        { output = "HDMI-0"; workspace = "28"; }
        { output = "HDMI-0"; workspace = "29"; }
        { output = "HDMI-0"; workspace = "20"; }
      ];
    };
  };
}
