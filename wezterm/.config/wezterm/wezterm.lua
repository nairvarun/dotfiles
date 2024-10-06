-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"
config.color_scheme = 'Catppuccin Mocha'
config.hide_mouse_cursor_when_typing = false
config.use_fancy_tab_bar = false
config.command_palette_bg_color = "#45475a"
config.command_palette_fg_color = "#bac2de"
config.window_frame = {
  border_left_width = '0.1cell',
  border_right_width = '0.1cell',
  border_bottom_height = '0.1cell',
  border_top_height = '0.1cell',
  border_left_color = '#f5c2e7',
  border_right_color = '#f5c2e7',
  border_bottom_color = '#f5c2e7',
  border_top_color = '#f5c2e7',
}

-- and finally, return the configuration to wezterm
return config
