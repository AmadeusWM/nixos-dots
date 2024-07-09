{ pkgs, config, ... }:
{
  # services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #   [org.gnome.desktop.wm.preferences]
  #   resize-with-right-button=true
  # '';
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      resize-with-right-button=true;
    };
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
