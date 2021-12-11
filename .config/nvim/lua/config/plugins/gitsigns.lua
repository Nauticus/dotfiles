local wk = require("which-key")
local gitsigns = require("gitsigns")

gitsigns.setup({
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" }
    },
    keymaps = {
        noremap = true,
        buffer = true,
        ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
        ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" }
    },
    sign_priority = 5,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 200,
        ignore_whitespace = true
    },
    current_line_blame_formatter_opts = {
        relative_time = true
    }
})

wk.register({
    name = "+gitsigns",
    s = { gitsigns.stage_hunk, "Stage hunk" },
    u = { gitsigns.undo_stage_hunk, "Undo stage hunk" },
    r = { gitsigns.reset_hunk, "Reset hunk" },
    p = { gitsigns.preview_hunk, "Preview hunk" },
    b = { gitsigns.blame_line, "Blame line" }
}, { prefix = "<leader>h" })

wk.register({
    s = {
        function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        "Stage hunk"
    },
    r = {
        function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        "Reset hunk"
    }

}, { mode = "v", prefix = "<leader>h" })
