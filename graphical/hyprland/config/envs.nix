{ pkgs, ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    # Log WLR errors and logs to the hyprland log. Recommended
    env = HYPRLAND_LOG_WLR, 1

    # Tell Xwayland to use a cursor theme
    env = XCURSOR_THEME, Xcursor-breeze

    # Set cursor size
    env = XCURSOR_SIZE, 24

    env = XDG_SESSION_TYPE, wayland
  '';
}
