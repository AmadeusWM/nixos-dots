{ pkgs, ... }:
{
  wayland.windowManager.hyprland.extraConfig = ''
    # Log WLR errors and logs to the hyprland log. Recommended
    env = HYPRLAND_LOG_WLR, 1

    # Tell Xwayland to use a cursor theme
    env = XCURSOR_THEME, Xcursor-breeze

    # unnecessary?
    # env = _JAVA_AWT_WM_NONREPARENTING, 1

    # Set cursor size
    env = XCURSOR_SIZE, 24

    # Nvidia stuff
    # env = LIBVA_DRIVER_NAME, nvidia
    # env = VDPAU_DRIVER, nvidia
    env = XDG_SESSION_TYPE, wayland
    #env = GBM_BACKEND=nvidia-drm # commenting this one out fixes firefox
    # env = __GLX_VENDOR_LIBRARY_NAME, nvidia
    # env = WLR_NO_HARDWARE_CURSORS, 1

    # Make all electron apps wayland (some might crash...)
    # env = NIXOS_OZONE_WL, 1;
  '';
}
