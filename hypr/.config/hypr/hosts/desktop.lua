-- Desktop-specific configuration

hl.monitor({ output = "DP-2",     mode = "highres",        position = "auto", scale = 2 })
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@120",  position = "auto", scale = 2 })

hl.config({
    input = {
        kb_layout  = "de",
        kb_options = "caps:escape",
        follow_mouse = 1,
        repeat_rate  = 38, -- was default 25, ~50% faster
        repeat_delay = 300,
        sensitivity  = -0.8,
        touchpad = { natural_scroll = false },
    },
})

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

hl.on("hyprland.start", function()
    hl.exec_cmd("swayosd-server -s ~/.config/swayosd/style.css")
    hl.exec_cmd("hypridle -c ~/.config/hypr/hypridle-desktop.conf")
end)
