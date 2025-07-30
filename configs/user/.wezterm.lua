local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28
config.window_background_opacity = 0.7
config.font_size = 16
config.enable_tab_bar = false
config.default_prog = { "powershell" }
config.window_decorations = "RESIZE"
config.window_padding = {left = 25, right = 25, top = 25, bottom = 25,}
config.default_cursor_style = "SteadyBar"

-- Fonts

--config.font = wezterm.font("Hack Nerd Font Regular")
   --config.font = wezterm.font("Hack Nerd Font Bold")

-- Ubuntu Mono Regular 
   --config.font = wezterm.font("UbuntuMono Nerd Font")

-- Ubuntu Mono Bold
   config.font = wezterm.font("UbuntuMono Nerd Font Bold")






-- Panes
local act = wezterm.action
config.keys = {
  { key = "c", mods = "CTRL|ALT", action = act.CloseCurrentPane({ confirm = false }) },
  { key = "b", mods = "CTRL|ALT", action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }) },
  { key = "v", mods = "CTRL|ALT", action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }) },

  { key = "-", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Left", 2 }) },
  { key = "[", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Down", 2 }) },
  { key = "]", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Up", 2 }) },
  { key = "=", mods = "CTRL|ALT", action = act.AdjustPaneSize({ "Right", 2 }) },
  
  { key = "9", mods = "CTRL", action = act.PaneSelect },
}

return config