hl.window_rule({
    name = "floorp",
    match = {class = "floorp"},
    workspace = "2"
})

hl.window_rule({
    name = "vesktop",
    match = {class = "vesktop"},
    workspace = "2"
})
 hl.config({
     general = {
  gaps_out = 10,
  gaps_workspaces = 10,
 -- col.nogroup_border_active = "0xffffffff",
  layout = "dwindle"
  },

  decoration = {
      rounding       = 8,
      rounding_power = 0,
  },

  cursor = {
      no_hardware_cursors = 1,
  }
})
