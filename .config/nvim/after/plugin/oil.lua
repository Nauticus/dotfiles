local has_oil, oil = pcall(require, "oil")
if not has_oil then
    vim.notify("oil is missing", vim.log.levels.WARN)
    return
end

oil.setup {
    columns = {
        -- "permissions",
        -- "size",
        -- "mtime",
        "icon",
    },
    view_options = {
        show_hidden = true,
    },
}

vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
