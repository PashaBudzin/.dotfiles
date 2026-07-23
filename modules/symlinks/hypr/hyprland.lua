require("keybinds")
require("colors")
require("run")
require("animations")

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

-- animations

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},

	animations = {
		-- enabled = true
	},

	input = {
		kb_options = "grp:win_space_toggle",
		kb_layout = "us,ua",
		touchpad = {
			disable_while_typing = false,
			natural_scroll = true,
		},
	},
})

hl.workspace_rule({ workspace = "2", layout = "scrolling", layout_opts = { direction = "right" } })

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
	},
	decoration = {
		rounding = 20,
		rounding_power = 2,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},
	},
})
