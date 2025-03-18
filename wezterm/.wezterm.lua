-- Pull in the Wezterm API
local wezterm = require("wezterm")
local os = require("os")

-- This will hold the Configuration
local config = wezterm.config_builder()

config.anti_alias_custom_block_glyphs = true
config.font = wezterm.font("JetBrainsMonoNL NFM SemiBold")

config.font_size = 14
config.window_background_opacity = 0.95

config.colors = {

	foreground = "#ebdbb2",
	background = "#1d2021",
	cursor_bg = "#ff9b21",
	cursor_border = "#ff9b21",
	cursor_fg = "#1d2021",
	selection_bg = "#665c54",
	selection_fg = "#ebdbb2",
	ansi = {
		"#1d2021",
		"#cc241d",
		"#98971a",
		"#d79921",
		"#458588",
		"#b16286",
		"#689d6a",
		"#a89984",
	},
	brights = {
		"#928374",
		"#fb4934",
		"#b8bb26",
		"#fabd2f",
		"#83a598",
		"#d3869b",
		"#8ec07c",
		"#ebdbb2",
	},
}

config.window_padding = {
	top = 0,
	right = 0,
	left = 10,
}

-- Hide the tab bar if only one tab is open
config.hide_tab_bar_if_only_one_tab = true
config.max_fps = 240 -- hack for smoothness
config.enable_kitty_graphics = true

-- Smooth hack
config.max_fps = 240

-- Enable Kitty Graphics
config.enable_kitty_graphics = true

config.keys = {

    {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
    -- Make Option-Right equivalent to Alt-f; forward-word
    {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
}

return config
