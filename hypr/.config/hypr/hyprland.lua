-- Hyprland 0.57+ Lua config (ported from hyprland.conf)

-- Load common configuration
require("hosts.common")

-- Load host-specific configuration
-- host.lua is a symlink created by install.sh based on hostname
require("host")
