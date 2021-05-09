vim.api.nvim_set_option('foldmethod', 'expr')
vim.api.nvim_set_option('foldexpr', 'nvim_treesitter#foldexpr()')
vim.api.nvim_set_option('foldlevel', 10)

local incremental_selection = {
    enable = true,
    keymaps = { init_selection = "gnn", node_incremental = "gn[", scope_incremental = "gn]", node_decremental = "gn)" }
}

local textobjects = {
    select = {
        enable = true,
        keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ii"] = "@call.inner",
            ["ai"] = "@call.outer"
        }
    }
}

require'nvim-treesitter.configs'.setup {
    highlight = { enable = 'maintained' },
    refactor = { highlight_definitions = { enable = true } },
    incremental_selection = incremental_selection,
    textobjects = textobjects,
    autopairs = {enable = true},
    indent = { enable = true },
    playground = {
        enable = true,
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true -- Whether the query persists across vim sessions
    }

}
