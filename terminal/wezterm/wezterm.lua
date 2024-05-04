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
config.exit_behavior = "Hold"
config.audible_bell = "Disabled"

-- Launch entries (https://wezfurlong.org/wezterm/config/launch.html#the-launcher-menu)
config.launch_menu = {
  {
    label = "Nixos",
    args = { 'broot', 'nixos' },
    cwd = "$HOME",
  },
  {
    label = "collaborative-drawing",
    args = { 'broot', '/home/amadeusw/projects/school/bapr/inf-bachpr-23-24-student-WolfM-2158257/collaborative-drawing' },
    cwd = "$HOME",
  },
  {
    label = "moq",
    args = { 'broot', '/home/amadeusw/projects/school/bapr/repos/moq' },
    cwd = "$HOME",
  },
  {
    label = "moq-rs",
    args = { 'broot', '/home/amadeusw/projects/school/bapr/repos/moq-rs' },
    cwd = "$HOME",
  },
  {
    label = "moq-js",
    args = { 'broot', '/home/amadeusw/projects/school/bapr/repos/moq-js' },
    cwd = "$HOME",
  },
}

-- Keybindings (https://wezfurlong.org/wezterm/config/keys.html#configuring-key-assignments)
config.keys = {
  -- Disable default keybind for fullscreen
  {key="Enter", mods="ALT", action="DisableDefaultAssignment"},
  { key = 'Backspace', mods = 'CTRL', action = wezterm.action.SendKey {key = 'w', mods = 'CTRL'} }, -- Fix Ctrl-Backspace not working: https://github.com/wez/wezterm/discussions/3983
  {
    key = ":",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|LAUNCH_MENU_ITEMS'},
  },
  {
    key = "q",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentPane { confirm = false  },
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
  },
  {
    key = "UpArrow",
    mods = "CTRL|ALT|SHIFT",
    action = wezterm.action.AdjustPaneSize { "Up", 3 },
  },
  {
    key = "RightArrow",
    mods = "CTRL|ALT|SHIFT",
    action = wezterm.action.AdjustPaneSize { "Right", 3 },
  },
  {
    key = "DownArrow",
    mods = "CTRL|ALT|SHIFT",
    action = wezterm.action.AdjustPaneSize { "Down", 3 },
  },
  {
    key = "LeftArrow",
    mods = "CTRL|ALT|SHIFT",
    action = wezterm.action.AdjustPaneSize { "Left", 3 },
  }
}

return config
