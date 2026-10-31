-- Laptop-specific configuration
local mainMod = require("vars").mainMod

----------------
--- MONITORS ---
----------------

-- External monitor (top):  3840x2160 @ scale 2    -> logical 1920x1080, origin 0,0
-- Laptop screen (bottom):  1920x1080 @ scale 1.25 -> logical 1536x864
--   centered under external: x = (1920 - 1536) / 2 = 192
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60", position = "0x0",     scale = 2 })
hl.monitor({ output = "eDP-1",    mode = "1920x1080@60", position = "192x1080", scale = 1.25 })
-- Fallback: any other connected output gets auto-detected
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

----------------------
--- WORKSPACE PINS ---
----------------------

-- External monitor (top) - workspaces 1-6; laptop screen (bottom) - 7-10
for i = 1, 6  do hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1" }) end
for i = 7, 10 do hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" }) end

-------------
--- INPUT ---
-------------

hl.config({
    input = {
        kb_layout  = "de",
        kb_options = "caps:escape",
        follow_mouse = 1,
        sensitivity  = -0.22,
        touchpad = {
            natural_scroll = true,
            scroll_factor  = 0.3,
        },
    },
})

-- toggle-rotation.sh rewrites the "transform = N" line below
hl.device({ name = "elan900c:00-04f3:2830",
    transform = 0 })
hl.device({ name = "logitech-usb-optical-mouse", sensitivity = -0.8 })

-------------------
--- KEYBINDINGS ---
-------------------

-- Toggle screen rotation
hl.bind("F9", hl.dsp.exec_cmd("~/.config/hypr/toggle-rotation.sh"))

-- Laptop LCD brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("~/.local/bin/swayosd-client --brightness raise"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.local/bin/swayosd-client --brightness lower"), { locked = true, repeating = true })

-- Focus other monitor: mod + , / .
hl.bind(mainMod .. " + comma",  hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ monitor = "r" }))

-- Move active window to other monitor: mod + SHIFT + , / .
hl.bind(mainMod .. " + SHIFT + comma",  hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ monitor = "r" }))

-- Move window to a workspace silently: mod + CTRL + [0-9]
for i = 1, 10 do
    hl.bind(mainMod .. " + CTRL + " .. (i % 10), hl.dsp.window.move({ workspace = i, follow = false }))
end

---------------
--- STARTUP ---
---------------

hl.on("hyprland.start", function()
    -- Custom swayosd with rotation fix
    hl.exec_cmd("~/.local/bin/swayosd-server -s ~/.config/swayosd/style.css")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("kanshi")
    hl.exec_cmd("~/.config/hypr/force-normal-orientation.sh")
    hl.exec_cmd("~/.config/hypr/pin-workspaces.sh")
    -- Chromium on misc workspace
    hl.exec_cmd("chromium --restore-last-session", { workspace = "5 silent" })
end)

-- Chromium is laptop-only
hl.window_rule({ match = { class = "^(chromium)$" }, workspace = "5 silent" })
