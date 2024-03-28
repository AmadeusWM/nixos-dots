local wezterm = require 'wezterm'
local config = {}

-- Customized catppuccin
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#11111b"
config.color_schemes = {
  ["Apatheia Catppuccin"] = custom,
}
config.color_scheme = "Apatheia Catppuccin"

config.font = wezterm.font 'FiraCode'
config.use_fancy_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.default_cursor_style = 'SteadyBlock'
config.animation_fps = 1 -- disables cursor easing in and out

-- Launch entries (https://wezfurlong.org/wezterm/config/launch.html#the-launcher-menu)
config.launch_menu = {
  -- TODO: this doesn't work for some rease, error: No viable candidates found in PATH
  {
    label = "Nixos",
    args = { 'br ~/nixos' }
  }
}

-- Keybindings (https://wezfurlong.org/wezterm/config/keys.html#configuring-key-assignments)
config.keys = {
  {
    key = ";",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ShowLauncher,
  },
  {
    key = "q",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = "h",
    mods = "CTRL|ALT",
    action = wezterm.action.SplitHorizontal,
  },
  {
    key = "v",
    mods = "CTRL|ALT",
    action = wezterm.action.SplitVertical,
  }
}

return config
