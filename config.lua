local modkey = "Mod4"

local terminal = "ghostty"

-- Color palette - customize these to match your theme
-- Alternatively you can import other files in here, such as
-- local colors = require("colors.lua") and make colors.lua a file
-- in the ~/.config/oxwm directory
local colors = {
	fg         = "#e0def4", -- text
	red        = "#eb6f92", -- love
	bg         = "#131724", -- base
	cyan       = "#9ccfd8", -- foam
	green      = "#31748f", -- pine (Rose Pine's closest thing to green)
	lavender   = "#908caa", -- subtle
	light_blue = "#9ccfd8", -- foam
	grey       = "#6e6a86", -- muted
	blue       = "#c4a7e7", -- iris
	purple     = "#c4a7e7", -- iris
}

-- Workspace tags - can be numbers, names, or icons (requires a Nerd Font)
local tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
--local tags = { "", "󰊯", "", "", "󰙯", "󱇤", "", "󱘶", "󰧮" } -- Example of nerd font icon tags

-- Font for the status bar (use "fc-list" to see available fonts)
local bar_font = "nerd font jetbrains-mono :style=Bold:size=10"

-- Define your blocks
-- Similar to widgets in qtile, or dwmblocks
local blocks = {
	oxwm.bar.block.shell({
		format = "{}",
		command = "echo A MAN DIES WHEN HIS DREAMS ARE FORGOTTEN",
		interval = 5,
		color = colors.red,
		underline = true,
	}),
	oxwm.bar.block.static({
		text = "│",
		interval = 999999999,
		color = colors.lavender,
		underline = false,
	}),
	oxwm.bar.block.datetime({
		format = "{}",
		date_format = "%a, %b %d - %-I:%M %P",
		interval = 1,
		color = colors.cyan,
		underline = true,
	}),
	-- Uncomment to add battery status (useful for laptops)
	--	oxwm.bar.block.battery({
	--		format = "Bat: {}%",
	--		charging = "⚡ Bat: {}%",
	--		discharging = "- Bat: {}%",
	--		full = "✓ Bat: {}%",
	--		interval = 30,
	--		color = colors.green,
	--		underline = true,
	-- click: run a command when the block is clicked
	-- click = "alacritty -e btop",
	-- click = { command = "bluetui", floating = true },
	--	}),
};

-------------------------------------------------------------------------------
-- Basic Settings
-------------------------------------------------------------------------------
oxwm.set_terminal(terminal)
oxwm.set_modkey(modkey) -- This is for Mod + mouse binds, such as drag/resize
oxwm.set_tags(tags)

-- Set default layout (tiling by default)
-- oxwm.set_layout("tiling")

-------------------------------------------------------------------------------
-- Layouts
-------------------------------------------------------------------------------
-- Set custom symbols for layouts (displayed in the status bar)
-- Available layouts: "tiling", "normie" (floating), "grid", "monocle", "tabbed", "dwindle"
oxwm.set_layout_symbol("tiling", "[T]")
oxwm.set_layout_symbol("normie", "[F]")
oxwm.set_layout_symbol("tabbed", "[=]")
oxwm.set_layout_symbol("dwindle", "[\\]")

-- Example: bind dwindle (fibonacci) layout
-- oxwm.key.bind({ modkey }, "R", oxwm.layout.set("dwindle"))

-- Set default layout of specific tag (tag_index, layout_name)
-- Unset value uses oxwm.set_layout value
-- oxwm.set_tag_layout(1, "grid")

-------------------------------------------------------------------------------
-- Appearance
-------------------------------------------------------------------------------
-- Border configuration

-- Width in pixels
oxwm.border.set_width(2)
-- Color of focused window border
oxwm.border.set_focused_color(colors.blue)
-- Color of unfocused window borders
oxwm.border.set_unfocused_color(colors.grey)

-- Where floating windows spawn: "top-left", "top-center", "top-right",
-- "center-left", "center", "center-right", "bottom-left", "bottom-center", "bottom-right"
oxwm.set_floating_position("center")

-- Smart Enabled = No border if 1 window
oxwm.gaps.set_smart(true)
-- Inner gaps (horizontal, vertical) in pixels
oxwm.gaps.set_inner(5, 5)
-- Outer gaps (horizontal, vertical) in pixels
oxwm.gaps.set_outer(5, 5)

-------------------------------------------------------------------------------
-- Window Rules
-------------------------------------------------------------------------------
-- Rules allow you to automatically configure windows based on their properties
-- You can match windows by class, instance, title, or role
-- Available properties: floating, tag, fullscreen, etc.
--
-- Common use cases:
-- - Force floating for certain applications (dialogs, utilities)
-- - Send specific applications to specific workspaces
-- - Configure window behavior based on title or class

-- Examples (uncomment to use):
-- oxwm.rule.add({ instance = "gimp", floating = true })
-- oxwm.rule.add({ class = "Alacritty", tag = 9, focus = true })
-- oxwm.rule.add({ class = "firefox", title = "Library", floating = true })
oxwm.rule.add({ class = "steam", tag = 2 })
-- oxwm.rule.add({ instance = "mpv", floating = true })

-- To find window properties, use xprop and click on the window
-- WM_CLASS(STRING) shows both instance and class (instance, class)

-------------------------------------------------------------------------------
-- Status Bar Configuration
-------------------------------------------------------------------------------
-- Font configuration
oxwm.bar.set_font(bar_font)

-- Position configuration (top/bottom, top is default)
-- oxwm.bar.set_position("bottom")

-- Set your blocks here (defined above)
oxwm.bar.set_blocks(blocks)

-- Bar color schemes (for workspace tag display)
-- Parameters: foreground, background, border

-- Unoccupied tags
oxwm.bar.set_scheme_normal(colors.fg, colors.bg, "fg")
-- Occupied tags
oxwm.bar.set_scheme_occupied(colors.cyan, colors.bg, colors.cyan)
-- Currently selected tag
oxwm.bar.set_scheme_selected(colors.cyan, colors.bg, colors.purple)
-- Urgent tags (windows requesting attention)
oxwm.bar.set_scheme_urgent(colors.red, colors.bg, colors.red)

-- Hide tags that have no windows and are not selected
-- oxwm.bar.set_hide_vacant_tags(true)

-------------------------------------------------------------------------------
-- Keybindings
-------------------------------------------------------------------------------
-- Common keys: Return, Space, Tab, Escape, Backspace, Delete, Left, Right, Up, Down

oxwm.key.bind({ modkey }, "Q", oxwm.spawn_terminal())
oxwm.key.bind({ modkey }, "W", oxwm.spawn({ "firefox" }))
oxwm.key.bind({ modkey }, "E", oxwm.spawn({ "pcmanfm" }))
oxwm.key.bind({ modkey }, "Tab", oxwm.spawn({ "sh", "-c", "dmenu_run -l 10" }))
oxwm.key.bind({ modkey }, "Print", oxwm.spawn({ "sh", "-c",
	'maim --select "$HOME/Pictures/Screenshots/$(date +%F_%H-%M-%S).png"' }))
-- Volume (wpctl, same as your i3 setup)
oxwm.key.bind({}, "XF86AudioRaiseVolume", oxwm.spawn({ "sh", "-c", "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+" }))
oxwm.key.bind({}, "XF86AudioLowerVolume", oxwm.spawn({ "sh", "-c", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" }))
oxwm.key.bind({}, "XF86AudioMute", oxwm.spawn({ "sh", "-c", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" }))
oxwm.key.bind({}, "XF86AudioMicMute", oxwm.spawn({ "sh", "-c", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" }))

-- Brightness
oxwm.key.bind({}, "XF86MonBrightnessUp", oxwm.spawn({ "sh", "-c", "brightnessctl set 5%+" }))
oxwm.key.bind({}, "XF86MonBrightnessDown", oxwm.spawn({ "sh", "-c", "brightnessctl set 5%-" }))
oxwm.key.bind({ modkey }, "C", oxwm.client.kill())

oxwm.key.bind({ modkey }, "F", oxwm.client.toggle_fullscreen())
oxwm.key.bind({ modkey }, "V", oxwm.client.toggle_floating())

oxwm.key.bind({ modkey }, "A", oxwm.layout.set("normie"))
oxwm.key.bind({ modkey }, "T", oxwm.layout.set("tiling"))
oxwm.key.bind({ modkey }, "Y", oxwm.layout.cycle())

-- Decrease/Increase master area width
oxwm.key.bind({ modkey }, "H", oxwm.set_master_factor(-5))
oxwm.key.bind({ modkey }, "L", oxwm.set_master_factor(5))
-- Enable tiled resize mode: Mod+RMB drag adjusts mfact instead of floating
-- oxwm.tiled_resize_mode(true)
-- Increment/Decrement number of master windows
oxwm.key.bind({ modkey }, "B", oxwm.inc_num_master(1))
oxwm.key.bind({ modkey }, "N", oxwm.inc_num_master(-1))

-- Gaps toggle
oxwm.key.bind({ modkey }, "X", oxwm.toggle_gaps())
-- Bar toggle
oxwm.key.bind({ modkey }, "Z", oxwm.toggle_bar())

-- Window manager controls
oxwm.key.bind({ modkey, "Shift" }, "Q", oxwm.quit())
oxwm.key.bind({ modkey, "Shift" }, "R", oxwm.restart())

-- Focus movement [1 for up in the stack, -1 for down]
oxwm.key.bind({ modkey }, "J", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey }, "K", oxwm.client.focus_stack(-1))

-- Window movement (swap position in stack)
oxwm.key.bind({ modkey, "Shift" }, "J", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey, "Shift" }, "K", oxwm.client.move_stack(-1))

-- Multi-monitor support

-- Focus next/previous Monitors
oxwm.key.bind({ modkey }, "Comma", oxwm.monitor.focus(-1))
oxwm.key.bind({ modkey }, "Period", oxwm.monitor.focus(1))
-- Move window to next/previous Monitors
oxwm.key.bind({ modkey, "Shift" }, "Comma", oxwm.monitor.tag(-1))
oxwm.key.bind({ modkey, "Shift" }, "Period", oxwm.monitor.tag(1))

-- Workspace (tag) navigation
-- Switch to workspace N (tags are 0-indexed, so tag "1" is index 0)
oxwm.key.bind({ modkey }, "1", oxwm.tag.view(0))
oxwm.key.bind({ modkey }, "2", oxwm.tag.view(1))
oxwm.key.bind({ modkey }, "3", oxwm.tag.view(2))
oxwm.key.bind({ modkey }, "4", oxwm.tag.view(3))
oxwm.key.bind({ modkey }, "5", oxwm.tag.view(4))
oxwm.key.bind({ modkey }, "6", oxwm.tag.view(5))
oxwm.key.bind({ modkey }, "7", oxwm.tag.view(6))
oxwm.key.bind({ modkey }, "8", oxwm.tag.view(7))
oxwm.key.bind({ modkey }, "9", oxwm.tag.view(8))

-- Move focused window to workspace N
oxwm.key.bind({ modkey, "Shift" }, "1", oxwm.tag.move_to(0))
oxwm.key.bind({ modkey, "Shift" }, "2", oxwm.tag.move_to(1))
oxwm.key.bind({ modkey, "Shift" }, "3", oxwm.tag.move_to(2))
oxwm.key.bind({ modkey, "Shift" }, "4", oxwm.tag.move_to(3))
oxwm.key.bind({ modkey, "Shift" }, "5", oxwm.tag.move_to(4))
oxwm.key.bind({ modkey, "Shift" }, "6", oxwm.tag.move_to(5))
oxwm.key.bind({ modkey, "Shift" }, "7", oxwm.tag.move_to(6))
oxwm.key.bind({ modkey, "Shift" }, "8", oxwm.tag.move_to(7))
oxwm.key.bind({ modkey, "Shift" }, "9", oxwm.tag.move_to(8))

-- Combo view (view multiple tags at once) {argos_nothing}
-- Example: Mod+Ctrl+2 while on tag 1 will show BOTH tags 1 and 2
oxwm.key.bind({ modkey, "Control" }, "1", oxwm.tag.toggleview(0))
oxwm.key.bind({ modkey, "Control" }, "2", oxwm.tag.toggleview(1))
oxwm.key.bind({ modkey, "Control" }, "3", oxwm.tag.toggleview(2))
oxwm.key.bind({ modkey, "Control" }, "4", oxwm.tag.toggleview(3))
oxwm.key.bind({ modkey, "Control" }, "5", oxwm.tag.toggleview(4))
oxwm.key.bind({ modkey, "Control" }, "6", oxwm.tag.toggleview(5))
oxwm.key.bind({ modkey, "Control" }, "7", oxwm.tag.toggleview(6))
oxwm.key.bind({ modkey, "Control" }, "8", oxwm.tag.toggleview(7))
oxwm.key.bind({ modkey, "Control" }, "9", oxwm.tag.toggleview(8))

-- Multi tag (window on multiple tags)
-- Example: Mod+Ctrl+Shift+2 puts focused window on BOTH current tag and tag 2
oxwm.key.bind({ modkey, "Control", "Shift" }, "1", oxwm.tag.toggletag(0))
oxwm.key.bind({ modkey, "Control", "Shift" }, "2", oxwm.tag.toggletag(1))
oxwm.key.bind({ modkey, "Control", "Shift" }, "3", oxwm.tag.toggletag(2))
oxwm.key.bind({ modkey, "Control", "Shift" }, "4", oxwm.tag.toggletag(3))
oxwm.key.bind({ modkey, "Control", "Shift" }, "5", oxwm.tag.toggletag(4))
oxwm.key.bind({ modkey, "Control", "Shift" }, "6", oxwm.tag.toggletag(5))
oxwm.key.bind({ modkey, "Control", "Shift" }, "7", oxwm.tag.toggletag(6))
oxwm.key.bind({ modkey, "Control", "Shift" }, "8", oxwm.tag.toggletag(7))
oxwm.key.bind({ modkey, "Control", "Shift" }, "9", oxwm.tag.toggletag(8))

-------------------------------------------------------------------------------
-- Advanced: Keychords
-------------------------------------------------------------------------------
-- Keychords allow you to bind multiple-key sequences (like Emacs or Vim)
-- Format: {{modifiers}, key1}, {{modifiers}, key2}, ...
-- Example: Press Mod4+Space, then release and press T to spawn a terminal
--oxwm.key.chord({
--	{ { modkey }, "Space" },
--	{ {},         "T" }
--}, oxwm.spawn_terminal())

-------------------------------------------------------------------------------
-- Autostart
-------------------------------------------------------------------------------
-- Commands to run once when OXWM starts
-- Uncomment and modify these examples, or add your own

oxwm.autostart("xrandr --output HDMI-1 --mode 1920x1080 --rate 180 --primary")
oxwm.autostart("feh --bg-scale /home/elliot/Pictures/Wallpapers/oxwm.jpg")
oxwm.autostart("picom")
oxwm.autostart("xinput set-prop 'Logitech G502 HERO Gaming Mouse' 'libinput Accel Profile Enabled' 0 1 0")
