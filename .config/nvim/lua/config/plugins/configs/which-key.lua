require("which-key").setup {
    plugins = {
        spelling = { enabled = true }
    },
    window = {
        border = "rounded",
        position = "bottom",
        padding = { 1, 0, 1, 0 },
        margin = { 2, 2, 2, 2 },
    },
    layout = {
        align = "center",
        width = { min = 20, max = 80 },
        spacing = 5,
    },
}
