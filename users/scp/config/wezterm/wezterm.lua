local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Spacegray Eighties (Gogh)'

config.font_size = 14
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.enable_scroll_bar = false
config.scrollback_lines = 5000

config.mouse_bindings = {
    {
      event = { Down = { streak = 1, button = { WheelUp = 1 } } },
      action = wezterm.action.ScrollByLine(-3),
    },
    {
      event = { Down = { streak = 1, button = { WheelDown = 1 } } },
      action = wezterm.action.ScrollByLine(3),
    },
}

config.keys = {
    {
        key = 'F',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.Search({ CaseInSensitiveString = '' })
    }
}

config.font = wezterm.font_with_fallback {
  "JetBrains Mono",
  "LXGW Neo XiHei",
}

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
