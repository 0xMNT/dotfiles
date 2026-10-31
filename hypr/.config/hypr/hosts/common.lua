local v = require("vars")
local mainMod = v.mainMod

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("waybar & hyprpaper & dunst &")
    hl.exec_cmd("~/.config/hypr/restore-wallpaper.sh")
    hl.exec_cmd("wlsunset -l 51.51 -L 7.5 -t 6000")

    hl.exec_cmd("firefox",                      { workspace = "1 silent" })
    hl.exec_cmd("alacritty",                    { workspace = "2 silent" })
    hl.exec_cmd("flatpak run com.spotify.Client", { workspace = "9 silent" })
    hl.exec_cmd("steam -silent",                { workspace = "10 silent" })
end)

-- Runs on every (re)load, like `exec =`
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_THEME", "Adwaita")
hl.env("GDK_SCALE", "2")
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,
        border_size = 0,
        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 1, -- min is 1 in 0.57 (rounding is 0 anyway)
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        dim_inactive = true,
        dim_strength = 0.3,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },
        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = { enabled = true },

    dwindle = { preserve_split = true },
    master  = { new_status = "master" },

    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        middle_click_paste       = false,
        focus_on_activate        = false,
        enable_swallow           = true,
        swallow_regex            = "^(com.mitchellh.alacritty)$",
    },

    debug     = { overlay = false },
    ecosystem = { no_update_news = true },
    xwayland  = { force_zero_scaling = true },

    -- Hide the mouse cursor when idle or while typing
    cursor = {
        inactive_timeout  = 3,
        hide_on_key_press = true,
    },

    input = {
        kb_layout  = "de",
        kb_variant = "",
        kb_model   = "",
        kb_options = "caps:escape",
        kb_rules   = "",
        follow_mouse = 1,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

hl.animation({ leaf = "global",           enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",           enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",          enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",        enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",           enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",          enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",             enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",           enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",     enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4,    bezier = "easeOutQuint", style = "slidevert" })

---------------------
---- KEYBINDINGS ----
---------------------

-- Reload hyprland config
hl.bind("ALT + SHIFT + R", hl.dsp.reload_config())

-- Toggle mod key between ALT and SUPER (Win)
hl.bind("ALT + SHIFT + B", hl.dsp.exec_cmd("~/.config/hypr/toggle-mod.sh"))

-- Alt+C/Alt+V as global copy/paste (forwards Ctrl+C/Ctrl+V to focused window)
hl.bind("ALT + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "C" }))
hl.bind("ALT + V", hl.dsp.send_shortcut({ mods = "CTRL", key = "V" }))

-- Screenshot a region and copy to clipboard via grim/slurp
hl.bind("ALT + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -b 00000080)" - | wl-copy'))

-- Cycle through wallpapers
hl.bind("SUPER + ALT + SPACE", hl.dsp.exec_cmd("~/.config/hypr/cycle-wallpaper.sh"))

-- Media keys (auto-unmute on volume change)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/volume-raise.sh"),                  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/volume-lower.sh"),                  { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

hl.bind("CTRL + ALT + Right", hl.dsp.exec_cmd("playerctl next"))
hl.bind("CTRL + ALT + Left",  hl.dsp.exec_cmd("playerctl previous"))
hl.bind("CTRL + ALT + SPACE", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(v.terminal))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + M",      hl.dsp.exit())
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(v.fileManager))
hl.bind(mainMod .. " + SPACE",  hl.dsp.exec_cmd(v.menu))
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen())

-- Move focus / windows with mainMod (+ SHIFT) + hjkl
local dirs = { h = "left", l = "right", k = "up", j = "down" }
for key, dir in pairs(dirs) do
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ direction = dir }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ direction = dir }))
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Previous workspace
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- hyprlock
hl.bind("SUPER + SHIFT + CTRL + L", hl.dsp.exec_cmd("~/.config/hypr/lock.sh"))

----------------------
---- WINDOW RULES ----
----------------------

local function ws_rule(class, ws)
    hl.window_rule({ match = { class = class }, workspace = ws })
end

ws_rule("^(chatgpt.com)$",             "special:term silent")
ws_rule("^(firefox)$",                 "1 silent")
ws_rule("^(com.mitchellh.alacritty)$", "2 silent")
ws_rule("^(Beyond-All-Reason)$",       "3 silent")
ws_rule("^(spotify)$",                 "5 silent")
ws_rule("^(calibre-ebook-viewer)$",    "6 silent")
ws_rule("^(discord)$",                 "8 silent")
ws_rule("^(steam)$",                   "10 silent")
