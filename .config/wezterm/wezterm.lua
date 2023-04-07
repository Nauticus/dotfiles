local wezterm = require("wezterm")

return {
    color_scheme = "Catppuccin Mocha",
    font = wezterm.font({
        family = "JetBrains Mono",
        harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
    }),
    window_decorations = "RESIZE",
    cursor_blink_rate = 0,
    font_antialias = "Subpixel",
    font_size = 13,
    line_height = 1.15,
    enable_tab_bar = false,
    window_background_image = "/Users/nauticus/Documents/wallpapers/astronaut-jellyfish-space-digital-art-uhdpaper.com-4K-107.jpg",
    text_background_opacity = 1,
    window_background_image_hsb = {
        brightness = 0.03,
    },
    window_padding = {
        left = 25,
        right = 25,
        top = 25,
        bottom = 15,
    },
}
