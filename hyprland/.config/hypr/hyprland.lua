-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
  output = "HDMI-A-2",
  mode = "2560x1440@120",
  scale = 1,
  position = "auto-left"
})

hl.monitor({
  output = "DP-2",
  mode = "3840x2160@60",
  position = "0x0",
  scale = 1.25,
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "footclient"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
  hl.exec_cmd("foot -s")
  hl.exec_cmd("ydotoold")
  hl.exec_cmd("noctalia")
  hl.exec_cmd("sleep 1 && footclient")
  hl.exec_cmd("google-chrome-stable --profile-directory=Default")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
-- hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_THEME", "bibata-modern-amber")
hl.env("HYPRCURSOR_SIZE", "28")
hl.env("NVD_BACKEND", "direct")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in     = 5,
    gaps_out    = 5,

    border_size = 2,


    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing    = false,

    layout           = "scrolling",
  },

  decoration = {
    rounding           = 10,
    rounding_power     = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity     = 1.0,
    inactive_opacity   = 1.0,
    fullscreen_opacity = 1.0,

    shadow             = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },

    blur               = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  cursor = {
    no_hardware_cursors = true,

  },
  animations = {
    enabled = true,
  },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
    wrap_focus = false,
    wrap_swapcol = false,
  },
})
hl.dsp.layout("inhibit_scroll")

----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
  },
})


---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout    = "us",
    kb_variant   = "",
    kb_model     = "",
    kb_options   = "",
    kb_rules     = "",

    follow_mouse = 1,

    sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad     = {
      natural_scroll = false,
    },
    repeat_rate  = 25,
    repeat_delay = 200,
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
  name        = "epic-mouse-v1",
  sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
hl.dsp.window.fullscreen_state({ internal = -1, client = -1 })

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ layout_aware = true }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({
  mode = "maximized",
  action = "toggle",
}))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
--hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h", hl.dsp.layout("focus l"))
hl.bind(mainMod .. " + l", hl.dsp.layout("focus r"))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "right" }))


hl.bind(mainMod .. " + SHIFT + h", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + x", hl.dsp.layout("colresize +conf"))
local CENTERED = false
hl.bind(mainMod .. " + c", function()
  local method = 0
  if CENTERED then
    method = 1
  else
    method = 0
  end
  hl.config({
    scrolling = {
      focus_fit_method = method
    }
  })
  hl.dispatch(hl.dsp.layout("fit_into_view"))
  CENTERED = not CENTERED
end)

hl.bind(mainMod .. " +  CTRL + left", hl.dsp.focus({ monitor = "left" }))
hl.bind(mainMod .. " +  CTRL + right", hl.dsp.focus({ monitor = "right" }))
hl.bind(mainMod .. " +  ALT + left", hl.dsp.window.move({ monitor = "left" }))
hl.bind(mainMod .. " +  ALT + right", hl.dsp.window.move({ monitor = "right" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")
smw.setup({
  workspace_count = 5, -- This will create 5 persistent workspaces on each monitor at startup
})
for i = 1, smw.get_amount_of_workspaces() do
  local n = tostring(i)
  if n == "10" then n = "0" end -- Optional if you configured 10 workspaces: bind workspace 10 to SUPER + 0
  -- Switch to the Nth workspace on the currently focused monitor.
  hl.bind(mainMod .. " +" .. n, smw.workspace(n))
  -- Move the active window to the Nth workspace on the currently focused monitor silently (no focus change).
  hl.bind(mainMod .. " + SHIFT +" .. n, smw.move_to_workspace_silent(n))
end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local ipc = "noctalia msg "

-- Core binds
hl.bind(mainMod .. "+Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. "+S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. "+comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind(mainMod .. "+B", hl.dsp.exec_cmd(ipc .. "bar-toggle"))
hl.bind(mainMod .. "+W", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher /win"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"), {  repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), {  repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"), {  repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"), {  repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"), {  repeating = true, locked = true })


hl.bind("SUPER + P", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))
hl.bind("SUPER + SHIFT + P",
  hl.dsp.exec_cmd(
  'grim -g "$(slurp -d)" $HOME/Pictures/Screenshots/$(date +%Y%m%d%H%M%S).png && notify-send "Screenshot saved to ~/Pictures/Screenshot"'))



-- Noctalia Settings
hl.window_rule({
  match = { class = "dev.noctalia.Noctalia" },
  float = true,
  size = { 1080, 920 },
})

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
local MAX_ZOOM = 4
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 2

---@param offset number
---@return nil
local function zoom(offset)
  local current = hl.get_config("cursor.zoom_factor")
  if offset ~= nil then
    current = current + offset
  elseif current ~= MIN_ZOOM then
    current = MIN_ZOOM
  else
    current = ZOOM_TOGGLE_FACTOR
  end
  current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
  hl.config({ cursor = { zoom_factor = current, zoom_detached_camera = false, zoom_rigid = true } })
end

hl.bind("SUPER + Z", zoom)
hl.bind("SUPER + mouse_up", function()
  zoom(0.5)
end)
hl.bind("SUPER + mouse_down", function()
  zoom(-0.5)
end)
hl.bind("SUPER + M", hl.dsp.submap("resizemove"))

-- Start a submap called "resize".
hl.define_submap("resizemove", function()
  hl.bind("l", hl.dsp.window.move({ x = 30, y = 0, relative = true }), { repeating = true })
  hl.bind("h", hl.dsp.window.move({ x = -30, y = 0, relative = true }), { repeating = true })
  hl.bind("j", hl.dsp.window.move({ x = 0, y = 30, relative = true }), { repeating = true })
  hl.bind("k", hl.dsp.window.move({ x = 0, y = -30, relative = true }), { repeating = true })

  -- Set repeating binds for resizing the active window.
  hl.bind("SHIFT + l", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
  hl.bind("SHIFT + h", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
  hl.bind("SHIFT + j", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })
  hl.bind("SHIFT + k", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })

  -- Use `reset` to go back to the global submap
  hl.bind("escape", hl.dsp.submap("reset"))
end)

local hyperKey = "SUPER + SHIFT + ALT + CTRL"

hl.bind(hyperKey .. " + B", hl.dsp.submap("cursor"))
hl.bind(hyperKey .. " + G", hl.dsp.exec_cmd("wl-kbptr && hyprctl dispatch 'hl.dsp.submap(\"cursor\")'"))

local dragging = false

hl.define_submap("cursor", function()
  local opts = {
    repeating = true,
  }

  -- Cursor movement
  hl.bind("h", hl.dsp.exec_cmd("ydotool mousemove -- -40 0"), opts)
  hl.bind("j", hl.dsp.exec_cmd("ydotool mousemove -- 0 40"), opts)
  hl.bind("k", hl.dsp.exec_cmd("ydotool mousemove -- 0 -40"), opts)
  hl.bind("l", hl.dsp.exec_cmd("ydotool mousemove -- 40 0"), opts)

  -- Faster movement
  hl.bind("SHIFT + h", hl.dsp.exec_cmd("ydotool mousemove -- -120 0"), opts)
  hl.bind("SHIFT + j", hl.dsp.exec_cmd("ydotool mousemove -- 0 120"), opts)
  hl.bind("SHIFT + k", hl.dsp.exec_cmd("ydotool mousemove -- 0 -120"), opts)
  hl.bind("SHIFT + l", hl.dsp.exec_cmd("ydotool mousemove -- 120 0"), opts)

  -- Left click
  hl.bind("Return", hl.dsp.exec_cmd("ydotool click 0xC0"), opts)

  -- Toggle drag
  hl.bind("SPACE", function()
    if dragging then
      hl.dispatch(hl.dsp.exec_cmd("ydotool click 0x80"))
      dragging = false
    else
      hl.dispatch(hl.dsp.exec_cmd("ydotool click 0x40"))
      dragging = true
    end
  end, opts)

  -- Scroll
  hl.bind("u", hl.dsp.exec_cmd("ydotool mousemove -w -- 0 -2"), opts)
  hl.bind("d", hl.dsp.exec_cmd("ydotool mousemove -w -- 0 2"), opts)

  -- Exit cursor mode
  hl.bind("escape", function()
    -- Don't leave the mouse button held when exiting.
    if dragging then
      hl.dispatch(hl.dsp.exec_cmd("ydotool click 0x80"))
      dragging = false
    end

    hl.dispatch(hl.dsp.submap("reset"))
  end, opts)
end)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})

hl.layer_rule({
  name = "noctalia",
  match = {
    namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
  },
  no_anim = true,
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})

hl.window_rule({
  match = {
    class = "hyprland-share-picker"
  },
  float = true,
})
hl.window_rule({
  match = {
    modal = true
  },
  float = true,
})

hl.bind("SUPER + slash", function()
  hl.dispatch(hl.dsp.exec_cmd(
    [[hyprctl clients -j | jq -e '.[] | select(.title == "scratchtodo")' >/dev/null || footclient -E -T scratchtodo tuxedo]]
  ))

  hl.dispatch(hl.dsp.workspace.toggle_special("scratchtodo"))
end)

hl.window_rule({
  match = {
    title = "scratchtodo",
  },
  workspace = "special:scratchtodo",
  float = true,
  size = { 1280, 800 }
})


hl.bind("SUPER + e", function()
  hl.dispatch(hl.dsp.exec_cmd(
    [[hyprctl clients -j | jq -e '.[] | select(.title == "scratchyazi")' >/dev/null || footclient -E -T scratchyazi yazi]]
  ))

  hl.dispatch(hl.dsp.workspace.toggle_special("scratchyazi"))
end)

hl.window_rule({
  match = {
    title = "scratchyazi",
  },
  workspace = "special:scratchyazi",
  float = true,
  size = { 1280, 800 }
})

-- For Noctalia Color templates
require("noctalia").apply_theme()
