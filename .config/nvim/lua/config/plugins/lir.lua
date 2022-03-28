local actions = require "lir.actions"
local mark_actions = require "lir.mark.actions"
local clipboard_actions = require "lir.clipboard.actions"

require("lir").setup {
    show_hidden_files = true,
    devicons_enable = true,
    mappings = {
        ["<CR>"] = actions.edit,
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
            mark_actions.toggle_mark()
            vim.cmd "normal! j"
        end,
        ["C"] = clipboard_actions.copy,
        ["X"] = clipboard_actions.cut,
        ["P"] = clipboard_actions.paste,
    },
    hide_cursor = false,
}

require("lir.git_status").setup {
    show_ignored = false,
}

require("config.mappings").lir_mappings()
