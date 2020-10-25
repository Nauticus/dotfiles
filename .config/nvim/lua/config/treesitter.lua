local M = {}

function M.init()
    vim.fn.nvim_set_option('foldmethod', 'expr')
    vim.fn.nvim_set_option('foldexpr', 'nvim_treesitter#foldexpr()')
    vim.fn.nvim_set_option('foldlevel', 10)

    local incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "gn[",
            scope_incremental = "gn]",
            node_decremental = "gn)",
        },

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
                ["ai"] = "@call.outer",

                -- Or you can define your own textobjects like this
                ["iF"] = {
                    python = "(function_definition) @function",
                    cpp = "(function_definition) @function",
                    c = "(function_definition) @function",
                    java = "(method_declaration) @function",
                },
            },
        },
    }

    require "nvim-treesitter.configs".setup {
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
      }
    }

    require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        highlight = {
            enable = true,
            use_languagetree = false,
            custom_captures = {
                ["jsx_expression.bracket"] = "GruvboxBlue",
                ["tag.intrinsic.delimiter"] = "TSTag",
                ["tag.type.delimiter"] = 'GruvboxOrange',
                ["tsx.named_imports.bracket"] = "GruvboxAqua",
                ["gruvbox.red"] = "GruvboxRed",
                ["gruvbox.yellow"] = "GruvboxYellow",
                ["gruvbox.blue"] = "GruvboxBlue",
                ["gruvbox.orange"] = "GruvboxOrange",
                ["gruvbox.fg2"] = "GruvboxFg2",
                ["tag.selfclosing"] = "GruvboxBlue",
                ["tdo"] = "TSTag",
                ["trr"] = "GruvboxOrange",
                ["jsx.self.closing.delimiter"] = "GruvboxOrange",
                ["tdd"] = "GruvboxOrange",
                ["tdc"] = "GruvboxRed"
            }
        },
        indent = {
            enable = true
        },
        refactor = {
            highlight_definitions = { enable = true },
        },
        incremental_selection = incremental_selection,
        textobjects = textobjects
    }
end

return M