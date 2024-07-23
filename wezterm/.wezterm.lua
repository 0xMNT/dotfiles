local wezterm = require("wezterm")

local config = wezterm.config_builder()
-- local mux = wezterm.mux

config.audible_bell = "Disabled"

config.enable_tab_bar = false
config.color_scheme = "Gooey (Gogh)"

config.font = wezterm.font("JetBrains Mono", { weight = "Light" })
config.font_size = 16

config.window_decorations = "NONE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- wezterm.on("gui-startup", function()
-- 	local tab, pane, window = mux.spawn_window({})
-- 	window:gui_window():maximize()
-- end)

return config
