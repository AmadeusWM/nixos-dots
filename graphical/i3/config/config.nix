{ config, lib, pkgs, ... }:

let 
  mod = "Mod4";
  alt = "Mod1";
in {
  # Example config: https://github.com/nix-community/nixos/blob/master/modules/services/window-managers/i3-sway/i3.nix
  # Change display position: `xrandr --output "eDP" --right-of "DisplayPort-0"`
  # home.pointerCursor = 
  #   let 
  #     getFrom = url: hash: name: {
  #         gtk.enable = true;
  #         x11.enable = true;
  #         name = name;
  #         size = 22;
  #         package = 
  #           pkgs.runCommand "moveUp" {} ''
  #             mkdir -p $out/share/icons
  #             ln -s ${pkgs.fetchzip {
  #               url = url;
  #               hash = hash;
  #             }} $out/share/icons/${name}
  #         '';
  #       };
  #   in
  #     getFrom 
  #       "https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.3/Bibata-Original-Ice.tar.gz"
  #       "sha256-nv1etub+GK/8KRnk/hSrBflaihdMXnSoFVJ65QryDws="
  #       "Bibata-Original-Ice";
  # home.pointerCursor = 
  #   let 
  #     getFrom = url: hash: name: {
  #         gtk.enable = true;
  #         x11.enable = true;
  #         name = name;
  #         size = 22;
  #         package = 
  #           pkgs.runCommand "moveUp" {} ''
  #             mkdir -p $out/share/icons
  #             ln -s ${pkgs.fetchzip {
  #               url = url;
  #               hash = hash;
  #             }} $out/share/icons/${name}
  #         '';
  #       };
  #   in
  #     getFrom 
  #       "https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.3/Bibata-Modern-Ice.tar.gz"
  #       "sha256-9lDvV2dgGFrLy8Y55ZYbiTDiN0DscX8Uju5YGWUuWyE="
  #       "Bibata-Modern-Ice";
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
  #             }} $out/share/icons/${name}
  #         '';
  #       };
  #   in
  #     getFrom 
  #       # "https://github.com/alvatip/Nordzy-cursors/releases/download/v0.6.0/Nordzy-cursors.tar.gz"
  #       # "sha256-TnVWPCmvcR42V9PKfZ77CMYrt7tYGWmQ9GN1Nr4QdNE="
  #       # "Nordzy";
  #       "https://github.com/alvatip/Nordzy-cursors/releases/download/v0.6.0/Nordzy-cursors-white.tar.gz"
  #       "sha256-ikU2xQHLuXkS0Wk7AY4KYmmiEUhabF9leHkP7YzjVZE="
  #       "Nordzy-White";
  home.pointerCursor = 
    let 
      getFrom = url: hash: name: {
          gtk.enable = true;
          x11.enable = true;
          name = name;
          size = 26;
          package = 
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
              }}/src/cursors/dist $out/share/icons/${name}
          '';
        };
    in
      getFrom 
        "https://github.com/vinceliuice/Qogir-icon-theme/archive/refs/tags/2023-06-05.tar.gz"
        "sha256-qiHmA/K4hdXVSFzergGhgssKR+kXp3X0cqtX1X5ayM4="
        "Qogir";
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      terminal = "kitty";
      keybindings = lib.mkOptionDefault {
        # Applications
        "${mod}+Control+m" = "exit";
        "${mod}+Control+n" = "exec XDG_CURRENT_DESKTOP=GNOME gnome-control-center wifi";
        "${mod}+m" = "exec morgen";
        "${mod}+t" = "exec kitty";
        "${alt}+Control+t" = "exec kitty";
        "${mod}+f" = "exec firefox";
        "${mod}+e" = "exec nautilus";
        "${mod}+w" = "exec code";
        "${mod}+o" = "exec obsidian";
        
        # Screen capture
        "${mod}+space" = "exec ${pkgs.dmenu}/bin/dmenu_run";
        "Print" = "exec flameshot gui -c -p ~/Pictures/Screenshots";
        "${alt}+Print" = "exec flameshot gui -p ~/Pictures/Screenshots";
        "${mod}+Print" = "exec deepin-screen-recorder --record --save-path '~/videos/Screen Recordings'";
        "${mod}+Control+l" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";

        # tools
        "${mod}+d" = "exec python3 ~/nixos/home/dots/graphical/i3/config/scripts/tools/dict.py";

        # i3 stuff
        "${mod}+q" = "kill";
        "--release ${mod}+Control+q" = "exec xkill"; # Doesn't work without `--release`
        "${mod}+a" = "fullscreen toggle";
        "${mod}+s" = "floating toggle";
        "${mod}+Control+s" = "exec i3-msg exit";
        "${mod}+r" = "layout toggle split";

        # Focus
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+i" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+i" = "move up";
        "${mod}+Shift+l" = "move right";

        # switch to workspace
        "${mod}+1" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh visit 1";
        "${mod}+2" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh visit 2";
        "${mod}+3" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh visit 3";
        "${mod}+4" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh visit 4";
        "${mod}+5" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh visit 5";
        "${mod}+6" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh visit 6";
        "${mod}+7" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh visit 7";
        "${mod}+8" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh visit 8";
        "${mod}+9" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh visit 9";
        "${mod}+0" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh visit 0";

        # move focused container to workspace
        "${alt}+1" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh move 1";
        "${alt}+2" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh move 2";
        "${alt}+3" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh move 3";
        "${alt}+4" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh move 4";
        "${alt}+5" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh move 5";
        "${alt}+6" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh move 6";
        "${alt}+7" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh move 7";
        "${alt}+8" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh move 8";
        "${alt}+9" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh move 9";
        "${alt}+0" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh move 0";

        # move focused container silently
        "${mod}+${alt}+1" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh movesilent 1";
        "${mod}+${alt}+2" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh movesilent 2";
        "${mod}+${alt}+3" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh movesilent 3";
        "${mod}+${alt}+4" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh movesilent 4";
        "${mod}+${alt}+5" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh movesilent 5";
        "${mod}+${alt}+6" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh movesilent 6";
        "${mod}+${alt}+7" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh movesilent 7";
        "${mod}+${alt}+8" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh movesilent 8";
        "${mod}+${alt}+9" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh movesilent 9";
        "${mod}+${alt}+0" = "exec ~/nixos/home/dots/graphical/i3/config/scripts/workspace.sh movesilent 0";

        # Audio
        "XF86AudioPlay" = "exec playerctl -p $(tail -1 /tmp/player-last) play-pause";
        "XF86AudioPrev" = "exec playerctl -p $(tail -1 /tmp/player-last) previous";
        "XF86AudioNext" = "exec playerctl -p $(tail -1 /tmp/player-last) next";

        "XF86AudioMedia" = "exec playerctl -p $(tail -1 /tmp/player-last) play-pause";
        "XF86AudioStop" = "exec playerctl -p $(tail -1 /tmp/player-last) stop";

        "XF86AudioRaiseVolume" = "exec ~/nixos/home/dots/services/dunst/scripts/volume up";
        "XF86AudioLowerVolume" = "exec ~/nixos/home/dots/services/dunst/scripts/volume down";
        "XF86AudioMute" = "exec ~/nixos/home/dots/services/dunst/scripts/volume mute";

        # brightness
        "XF86MonBrightnessUp" = "exec ~/nixos/home/dots/services/dunst/scripts/brightness up";
        "XF86MonBrightnessDown" = "exec ~/nixos/home/dots/services/dunst/scripts/brightness down";

        # System Shortcuts
        "XF86Calculator" = "exec kitty qalc";
      };
      startup = [
          # Put screens right
          {
            command = "xrandr --output 'eDP' --scale 0.75x0.75 --right-of 'DisplayPort-0'";
            always = true;
            notification = false;
          }
          # {
          #   command = "xrandr --dpi 160";
          #   always = true;
          #   notification = false;
          # }
          # Linux wallpaper engine
          # TODO: Use `--assets-dir <path>` and add the assets to dotfiles (assets folder: )
          # {
          #   command = ''
          #   killall linux-wallpaperengine; \
          #   linux-wallpaperengine --screen-root HDMI-A-0 --screen-root eDP --screen-root DisplayPort-0 2920436737 # Wind Waker Boat
          #   '';
          #   # linux-wallpaperengine --screen-root HDMI-A-0 --screen-root eDP --screen-root DisplayPort-0 1963289691  # howl's moving castle house
          #   # linux-wallpaperengine --screen-root HDMI-A-0 --screen-root eDP --screen-root DisplayPort-0 1896225027 # Light Fox
          #   # linux-wallpaperengine --screen-root HDMI-A-0 --screen-root eDP --screen-root DisplayPort-0 2307226588 # Shopping Mall
          #   # linux-wallpaperengine --screen-root HDMI-A-0 --screen-root eDP --screen-root DisplayPort-0 2949070251 # Spring Sale
          #   # linux-wallpaperengine --screen-root HDMI-A-0 --screen-root eDP --screen-root DisplayPort-0 2985464274  # mushroom marshmallow
          #   # linux-wallpaperengine --screen-root HDMI-A-0 --screen-root eDP --screen-root DisplayPort-0 2847439574 # Cat on roof
          #   # linux-wallpaperengine --screen-root HDMI-A-0 --screen-root eDP --screen-root DisplayPort-0 2866220216 # Sword in Stone Zelda
          #   always = true;
          #   notification = false;
          # }
          # feh wallpaper
          {
            # command = "feh --bg-scale /home/amadeusw/Pictures/wallpapers/pixel-skyline.png";
            command = "feh --bg-center /home/amadeusw/Pictures/wallpapers/wallpapers/widescreen/greenbruh.png";
            # command = "feh --bg-center /home/amadeusw/Pictures/wallpapers/wallpapers/pixelart/MasterSword.png";
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
      ];
      # Assign Workspaces to Screens
      # i3-msg -t get_outputs
      workspaceOutputAssign = [
        { output = "eDP"; workspace = "1"; }
        { output = "eDP"; workspace = "2"; }
        { output = "eDP"; workspace = "3"; }
        { output = "eDP"; workspace = "4"; }
        { output = "eDP"; workspace = "5"; }
        { output = "eDP"; workspace = "6"; }
        { output = "eDP"; workspace = "7"; }
        { output = "eDP"; workspace = "8"; }
        { output = "eDP"; workspace = "9"; }
        { output = "eDP"; workspace = "0"; }

        { output = "DisplayPort-0"; workspace = "11"; }
        { output = "DisplayPort-0"; workspace = "12"; }
        { output = "DisplayPort-0"; workspace = "13"; }
        { output = "DisplayPort-0"; workspace = "14"; }
        { output = "DisplayPort-0"; workspace = "15"; }
        { output = "DisplayPort-0"; workspace = "16"; }
        { output = "DisplayPort-0"; workspace = "17"; }
        { output = "DisplayPort-0"; workspace = "18"; }
        { output = "DisplayPort-0"; workspace = "19"; }
        { output = "DisplayPort-0"; workspace = "10"; }

        { output = "HDMI-A-0"; workspace = "21"; }
        { output = "HDMI-A-0"; workspace = "22"; }
        { output = "HDMI-A-0"; workspace = "23"; }
        { output = "HDMI-A-0"; workspace = "24"; }
        { output = "HDMI-A-0"; workspace = "25"; }
        { output = "HDMI-A-0"; workspace = "26"; }
        { output = "HDMI-A-0"; workspace = "27"; }
        { output = "HDMI-A-0"; workspace = "28"; }
        { output = "HDMI-A-0"; workspace = "29"; }
        { output = "HDMI-A-0"; workspace = "20"; }
      ];
    };
  };
}