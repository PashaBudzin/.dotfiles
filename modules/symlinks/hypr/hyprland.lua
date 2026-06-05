require("keybinds")
require("colors")
require("run")
require("animations")


hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- animations

hl.config({
    xwayland = {
        force_zero_scaling = true
    },

    animations = {
        -- enabled = true
    },

    input = {
        kb_options = "grp:win_space_toggle",
        kb_layout  = "us,ua",
        touchpad   = {
            disable_while_typing = false,
            natural_scroll = true
        }
    }
})
