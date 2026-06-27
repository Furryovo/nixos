hl.monitor({
    output = "DP-1",
    mode = "2560x1440@180",
    position = "1920x209",
    cm = "hdr",
    bitdepth = 10,
    vrr = 1,
    sdrbrightness = 2.2,
    sdrsaturation = 1.1,
})

hl.monitor({
    output = "DP-2",
    mode = "1920x1080@60",
    position = "840x0",
    transform = 1,
})

hl.monitor({
    output = "DP-3",
    mode = "1920x1080@60",
    position = "4480x0",
    transform = 3,
})
