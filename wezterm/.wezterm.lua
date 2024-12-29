local wezterm = require("wezterm")
local mux = wezterm.mux -- fullscreen

local config = wezterm.config_builder()

config.audible_bell = "Disabled"

config.enable_tab_bar = false
config.color_scheme = "Gooey (Gogh)"

config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Light" })
config.font_size = 16
config.enable_kitty_graphics = true

config.window_decorations = "NONE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

wezterm.on("gui-startup", function(window)
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	gui_window:perform_action(wezterm.action.ToggleFullScreen, pane)
end)

return config
