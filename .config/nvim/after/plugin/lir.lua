local has_lir, lir = pcall(require, "lir")
if not has_lir then
    vim.notify("lir is missing", vim.log.levels.WARN)
    return
end

local actions = require "lir.actions"
local mark_actions = require "lir.mark.actions"
local clipboard_actions = require "lir.clipboard.actions"

lir.setup {
    show_hidden_files = true,
    devicons_enable = true,
    mappings = {
        ["<CR>"] = actions.edit,
        ["l"] = actions.edit,
        ["<C-s>"] = actions.split,
        ["<C-v>"] = actions.vsplit,
        ["<C-t>"] = actions.tabedit,

        ["h"] = actions.up,
        ["-"] = actions.up,
        ["q"] = actions.quit,

        ["K"] = actions.mkdir,
        ["N"] = actions.newfile,
        ["R"] = actions.rename,
        ["@"] = actions.cd,
        ["Y"] = actions.yank_path,
        ["."] = actions.toggle_show_hidden,
        ["D"] = actions.delete,

        ["J"] = function()
            mark_actions.toggle_mark "n"
        end,
        ["C"] = clipboard_actions.copy,
        ["X"] = clipboard_actions.cut,
        ["P"] = clipboard_actions.paste,
    },
    hide_cursor = false,
}

-- stylua: ignore start
vim.keymap.set("n", "§", "<CMD>e .<CR>",     { desc = "Open current working directory" })
vim.keymap.set("n", "-", "<CMD>e %:p:h<CR>", { desc = "Open parent directory" })
-- stylua: ignore end

local has_lir_git_status, lir_git_status = pcall(require, "lir.git_status")
if not has_lir_git_status then
    vim.notify("lir.git_status is missing", vim.log.levels.WARN)
    return
end

lir_git_status.setup {
    show_ignored = false,
}
