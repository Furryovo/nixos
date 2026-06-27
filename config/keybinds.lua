-- ==================== General Binds ====================
hl.bind("SUPER + RETURN",  hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + E",       hl.dsp.exec_cmd("dolphin"))
hl.bind("SUPER + SPACE",   hl.dsp.exec_cmd("wofi"))
hl.bind("SUPER + B",       hl.dsp.exec_cmd("floorp"))
hl.bind("SUPER + Q",       hl.dsp.window.close())
--hl.bind("SUPER + SHIFT + M", hl.dsp.exec("loginctl terminate-user"}))
hl.bind("SUPER + V",       hl.dsp.window.float())
hl.bind("SUPER + F",       hl.dsp.window.fullscreen())

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" -t ppm - | satty --filename -'))

-- ==================== Volume Control ====================

hl.bind("F12", hl.dsp.exec_cmd([[
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ &&
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}' > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob
]]), { repeat_key = true, locked = true })

hl.bind("F11", hl.dsp.exec_cmd([[
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%- &&
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}' > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob
]]), { repeat_key = true, locked = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd([[
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ &&
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}' > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob
]]), { repeat_key = true, locked = true })

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd([[
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%- &&
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}' > /tmp/$HYPRLAND_INSTANCE_SIGNATURE.wob
]]), { repeat_key = true, locked = true })

-- ==================== Playback Control ====================
hl.bind("XF86AudioPlay",   hl.dsp.exec_cmd("playerctl play-pause"),  { repeat_key = false })
hl.bind("XF86AudioPrev",   hl.dsp.exec_cmd("playerctl previous"),    { repeat_key = false })
hl.bind("XF86AudioNext",   hl.dsp.exec_cmd("playerctl next"),        { repeat_key = false })

hl.bind("F8",   hl.dsp.exec_cmd("playerctl play-pause"),  { repeat_key = false })
hl.bind("F7",   hl.dsp.exec_cmd("playerctl previous"),    { repeat_key = false })
hl.bind("F9",   hl.dsp.exec_cmd("playerctl next"),        { repeat_key = false })

-- ==================== Window / Focus / Move ====================
-- Mouse drag
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true, desc = "Drag to move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, desc = "Drag to resize window" })

-- Move focus
hl.bind("SUPER + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Move window
hl.bind("SUPER + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + down",  hl.dsp.window.move({ direction = "down" }))

-- ==================== Resize Submap ====================
hl.define_submap("resize", function()
hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind("SUPER + R", hl.dsp.submap("resize"), { desc = "Activate resize mode" })

-- ==================== Workspaces ====================
for i=1, 10 do
 local key = i % 10
hl.bind("SUPER +" .. key, hl.dsp.focus({ workspace = i }))
hl.bind("SUPER + SHIFT+" .. key, hl.dsp.window.move({ workspace = i }))
end
    -- ==================== Misc Options ====================
    hl.config({
        binds = {
            allow_workspace_cycles   = true,
            workspace_back_and_forth = true,
            workspace_center_on      = true,
        },
    })
