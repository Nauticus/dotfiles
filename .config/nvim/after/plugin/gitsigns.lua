local has_gitsigns, gitsigns = pcall(require, "gitsigns")
if not has_gitsigns then
    vim.notify("gitsigns is missing", vim.log.levels.WARN)
    return
end

gitsigns.setup {
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
    keymaps = {
        noremap = true,
        buffer = true,
        ["n ]c"] = {
            expr = true,
            "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
        },
        ["n [c"] = {
            expr = true,
            "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
        },
    },
    sign_priority = 5,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 200,
        ignore_whitespace = true,
    },
    current_line_blame_formatter_opts = {
        relative_time = true,
    },
}

-- if pcall(require, "scrollbar.handlers.gitsigns") then
--     require("scrollbar.handlers.gitsigns").setup()
-- end
