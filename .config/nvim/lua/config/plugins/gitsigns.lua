local M = {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
    require("gitsigns").setup({
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },
        sign_priority = 5,
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
            delay = 700,
            ignore_whitespace = true,
        },
        current_line_blame_formatter_opts = {
            relative_time = true,
        },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map("n", "]c", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Select next hunk" })

            map("n", "[c", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Select previous hunk" })

            -- Actions
            map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
            map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
            map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
            map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })

            map("n", "<leader>gs", gs.stage_buffer, { desc = "Stage buffer" })
            map("n", "<leader>gr", gs.reset_buffer, { desc = "Reset buffer" })
            map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })

            map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
            map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
        end,
    })
end

return M
