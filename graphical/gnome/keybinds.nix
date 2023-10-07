{ pkgs, config, ... }:
{
  # from 
  # 1. https://discourse.nixos.org/t/nixos-options-to-configure-gnome-keyboard-shortcuts/7275
  # 2. https://the-empire.systems/nixos-gnome-settings-and-keyboard-shortcuts
  # check with `dconf dump /`:
  # cd Documents/Test
  # dconf dump / > old.conf.txt
  # dconf dump / > new.conf.txt
  # diff old.conf.txt new.conf.txt
  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      toggle-fullscreen=["<Super>a"];
      # show-all-apps = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "kitty super";
      command = "kitty";
      binding = "<Super>t";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "kitty ctrl_alt";
      command = "kitty";
      binding = "<Ctrl><Alt>t";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "firefox";
      command = "firefox";
      binding = "<Super>f";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      name = "vs code";
      command = "code";
      binding = "<Super>w";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
      name = "nautilus";
      command = "nautilus";
      binding = "<Super>e";
    };
  };
}