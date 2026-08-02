------------------
---- MONITORS ----
------------------
-- https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output = "DP-4",
    mode = "preferred",
    position = "0x0",
    scale = "auto",
})
hl.monitor({
    output = "HDMI-A-2",
    mode = "preferred",
    position = "auto-right",
    scale= 1,
})

------------------
---- PROGRAMS ----
------------------
local terminal = "kitty -e tmux new-session -A -s playground"
local file_manager = "dolphin"
local menu = "$HOME/.config/rofi/scripts/start_launcher.sh"
local sel_audio_out = "$HOME/.config/rofi/scripts/sel_audio_out"
local sel_audio_in = "$HOME/.config/rofi/scripts/sel_audio_in"
local timer = "$HOME/.config/rofi/scripts/rw_timer.sh"
local select_match = "$HOME/.config/rofi/scripts/select_match"
local volume_noti = "$HOME/.config/hypr/scripts/show_volume_noti"
local waybar_reload = "pkill waybar && hyprctl dispatch exec waybar"

-------------------
---- AUTOSTART ----
-------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function ()
    hl.exec_cmd("dunst")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprswitch init")
    hl.exec_cmd("flameshot")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("xrandr --output DP-4 --primary")
    hl.exec_cmd("$HOME/.config/tmux/import_env")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("QT_SCREEN_SCALE_FACTORS", "1;1")

-----------------------
----- PERMISSIONS -----
-----------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
hl.config({
  ecosystem = {
    enforce_permissions = true,
  },
})

hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
	gaps_in = 0,
	gaps_out = 0,
	border_size = 2,
	col = {
	    active_border = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
	    inactive_border = "rgba(595959aa)",
	},
	resize_on_border = false,
	allow_tearing = false,
	layout = "dwindle",
    },

    decoration = {
	rounding = 0,
	rounding_power = 3,
	active_opacity = 1.0,
	inactive_opacity = 0.9,
	shadow = {
	    enabled = true,
	    range = 4,
	    render_power = 3,
	    color = "rgba(1a1a1aee)",
	},
	blur = {
	    enabled = true,
	    size = 3,
	    passes = 1,
	    vibrancy = 0.1696,
	}
    },

    animations = {
	enabled = false,
    },
})

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.workspace_rule({ workspace = "1", monitor = "DP-4", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-4", default = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-4", default = true })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-2", default = true })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-2", default = true })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-2", default = true })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-2", default = true })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
	preserve_split = true,
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
    },
})

----------------
----  MISC  ----
----------------
hl.config({
    misc = {
	force_default_wallpaper = 0,
	disable_hyprland_logo = true,
	focus_on_activate = true,
    },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
	kb_layout = "us",
	kb_variant = "altgr-intl",
	kb_model = "",
	kb_options = "",
	kb_rules = "",

	follow_mouse = 1,

	sensitivity = 0,

	touchpad = {
	    natural_scroll = false,
	},
    },
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
-- https://wiki.hypr.land/Configuring/Basics/Binds/
local main_mod = "SUPER"

-- Misc
hl.bind(main_mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + A", hl.dsp.exec_cmd(sel_audio_out))
hl.bind(main_mod .. " + SHIFT + A", hl.dsp.exec_cmd(sel_audio_in))
hl.bind(main_mod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen())
--hl.bind(main_mod .. " + G", "togglegroup")
hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())
hl.bind(main_mod .. " + Q", hl.dsp.window.kill())
hl.bind(main_mod .. " + R", hl.dsp.exec_cmd(waybar_reload))
hl.bind(main_mod .. " + T", hl.dsp.exec_cmd(timer))
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd(select_match))
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("ALT + Tab", hl.dsp.exec_cmd("hyprswitch simple"))
hl.bind("ALT + SHIFT + Tab", hl.dsp.exec_cmd("hyprswitch simple -r"))

-- Screenshotting
hl.bind(main_mod .. " + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprctl -j activewindow | jq -r '\"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\"' | grim -g - - | wl-copy"))

-- Move / focus change
hl.bind(main_mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + L", hl.dsp.focus({ direction = "right"}))
hl.bind(main_mod .. " + K", hl.dsp.focus({ direction = "up"}))
hl.bind(main_mod .. " + J", hl.dsp.focus({ direction = "down"}))
hl.bind(main_mod .. " + ALT + H", hl.dsp.group.prev())
hl.bind(main_mod .. " + ALT + L", hl.dsp.group.next())

-- SYSTEM mode
hl.bind(main_mod .. " + C", hl.dsp.submap("system"))
hl.define_submap("system", function()
    hl.bind("E", function()
	hl.dispatch(
	    hl.dsp.exec_cmd(
		"command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
	    )
	)
	hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("L", function()
	hl.dispatch(hl.dsp.exec_cmd("hyprlock"))
	hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("P", function()
	hl.dispatch(hl.dsp.exec_cmd("shutdown -h now"))
	hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("R", function()
	hl.dispatch(hl.dsp.exec_cmd("reboot"))
	hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- LAUNCH mode
hl.bind(main_mod .. " + M", hl.dsp.submap("launch"))
hl.define_submap("launch", function()
    hl.bind("D", function()
	hl.dispatch(hl.dsp.exec_cmd("discord"))
	hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("F", function()
	hl.dispatch(hl.dsp.exec_cmd("firefox"))
	hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("S", function()
	hl.dispatch(hl.dsp.exec_cmd("spotify-launcher"))
	hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("SHIFT + S", function()
	hl.dispatch(hl.dsp.exec_cmd("steam"))
	hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("T", function()
	hl.dispatch(hl.dsp.exec_cmd("thunderbird"))
	hl.dispatch(hl.dsp.submap("reset"))
    end)
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Workspace switching and window moving
for i = 1,10 do
    local key = i % 10
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- move workspace to different monitor
hl.bind(main_mod .. " + CTRL + H", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(main_mod .. " + CTRL + L", hl.dsp.workspace.move({ monitor = "r" }))

-- move/resize windows with main_mod + LMB/RMB and dragging
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && " .. volume_noti))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && " .. volume_noti))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle %- && " .. volume_noti))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

-- requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl --player=spotify next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl --player=spotify previous"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl --player=spotify play-pause"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl --player=spotify play-pause"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.window_rule({
    -- Ignore maximize requests from apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})
hl.window_rule({
    name = "youtube-no-opacity",
    match = {
	title = "(.*)(- YouTube)(.*)",
    },

    opacity = "1 override",
})
hl.window_rule({
    name = "disney-no-opacity",
    match = {
	title = "(.*)(| Disney+)(.*)",
    },

    opacity = "1 override",
})
hl.window_rule({
    name = "make-pip-floating",
    match = {
	title = "^(Picture-in-Picture)",
    },

    float = true,
})
hl.window_rule({
    -- to get an undecorated window of chrome it needs to be started in fullscreen/kiosk mode
    -- via cmd line option and then gets its fullscreen mode disabled
    name = "chrome-no-fullscreen-kiosk",
    match = {
	class = "^(google-chrome)",
    },

    fullscreen_state = 0,
})
hl.window_rule({
    name = "make-adofai-fullscreen",
    match = {
	class = "^(ADanceOfFireAndIce)",
    },

    fullscreen = true,
})
hl.window_rule({
    name = "adofai-level-select",
    match = {
	class = "^(Menci)",
	title = "^(Open Level)",
    },

    float = true,
})
hl.window_rule({
    name = "make-valheim-fullscreen",
    match = {
	class = "^(valheim.x86_64)",
    },

    fullscreen = true,
})
hl.window_rule({
    name = "make-playwright-tests-work",
    match = {
	class = "^(chromium-browser)",
    },

    float = true,
})
-- might not be needed anymore
--hl.window_rule({
--    name = "flameshot-multi-display-fix",
--    match = {
--	class = "flameshot",
--    },
--
--    animation = "fade",
--    rounding = 0,
--    border_size = 0,
--    fullscreen_state = "0 0",
--    float = "on",
--    pin = "on",
--    monitor = "DP-4",
--    move = "0 0",
--    size = "(monitor_w*2) (monitor_h)",
--})
hl.window_rule({
    match = {
	class = "^(steam)",
    },
    workspace = 3,
})
hl.window_rule({
    match = {
	class = "^(Civ6)",
    },
    workspace = 3,
})
hl.window_rule({
    match = {
	class = "^(valheim.x86_64)",
    },
    workspace = 3,
})
hl.window_rule({
    match = {
	class = "^(bg3)",
    },
    workspace = 3,
})
hl.window_rule({
    match = {
	class = "^(Spotify)",
    },
    workspace = 4,
})
hl.window_rule({
    match = {
	class = "^(signal)",
    },
    workspace = 5,
})
hl.window_rule({
    match = {
	class = "^(Element)",
    },
    workspace = 5,
})
hl.window_rule({
    match = {
	class = "^(org.mozilla.Thunderbird)",
    },
    workspace = 6,
})
hl.window_rule({
    match = {
	class = "^(discord)",
    },
    workspace = 7,
})

-- programs like steam and brave looked really shitty (pixelated) on 4k monitor
-- apparently they run under xwayland and this forces them to not scale on their
-- own which results in the shitty appearence
hl.config({
    xwayland = {
	force_zero_scaling = true,
    },
})
