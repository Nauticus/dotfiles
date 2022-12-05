local has_which_key, which_key = pcall(require, "which-key")
if not has_which_key then
    vim.notify("which-key is missing", vim.log.levels.WARN)
    return
end

which_key.setup {
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
