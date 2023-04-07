return {
    "tamago324/lir.nvim",
    lazy = false,
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "tamago324/lir-git-status.nvim",
    },
    keys = {
        { "-", "<CMD>e %:p:h<CR>", desc = "Open parent directory" },
    },
    config = function()
        local lir = require("lir")
        local actions = require("lir.actions")
        local mark_actions = require("lir.mark.actions")
        local clipboard_actions = require("lir.clipboard.actions")

        lir.setup({
            show_hidden_files = true,
            devicons = {
                enable = true,
                highlight_dirname = true,
            },
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
                    mark_actions.toggle_mark("n")
                end,
                ["C"] = clipboard_actions.copy,
                ["X"] = clipboard_actions.cut,
                ["P"] = clipboard_actions.paste,
            },
            hide_cursor = false,
        })

        local lir_git_status = require("lir.git_status")

        lir_git_status.setup({
            show_ignored = false,
        })
    end,
}
