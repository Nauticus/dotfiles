return {
    "stevearc/oil.nvim",
    lazy = false,
    enabled = true,
    keys = {
        {
            "-",
            function()
                require("oil").open()
            end,
            desc = "Open parent directory",
        },
    },
    opts = {
        columns = {
            -- "permissions",
            -- "size",
            -- "mtime",
            "icon",
        },
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-v>"] = "actions.select_vsplit",
            ["<C-s>"] = "actions.select_split",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-r>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["g."] = "actions.toggle_hidden",
        },
        use_default_keymaps = false,
        view_options = {
            show_hidden = true,
        },
    },
    config = function(_, opts)
        require("oil").setup(opts)
    end,
}
