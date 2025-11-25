local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'DoomOne'

config.font_size = 13
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

wezterm.on("window-config-reloaded", function(window, pane)
  local cfg = window:effective_config()
  print("Window Padding:", cfg.window_padding)
  print("Font:", cfg.font.family)
  print("Color Scheme:", cfg.color_scheme)
end)

return config
