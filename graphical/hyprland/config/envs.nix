{ pkgs, ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    # Log WLR errors and logs to the hyprland log. Recommended
    env = HYPRLAND_LOG_WLR, 1

    # Tell Xwayland to use a cursor theme
    # env = XCURSOR_THEME, Xcursor-breeze
    # env = XCURSOR_THEME, Qogir
    env = XCURSOR_THEME, pixelfun2
    env = XCURSOR_SIZE, 24
    # env = HYPRCURSOR_THEME,HyprBibataModernClassicSVG
    # env = HYPRCURSOR_SIZE,24
    # exec-once = gsettings set org.gnome.desktop.interface cursor-theme Bibata-Modern-Classic
    # exec-once = hyprctl setcursor 'Bibata-Original-Classic' 24


    env = XDG_SESSION_TYPE, wayland
    env = NIXOS_OZONE_WL, "1"
    env = MOZ_ENABLE_WAYLAND, 1
    env = WLR_NO_HARDWARE_CURSORS, 1 # make sure cursor visible when mirroring screen
  '';
}
