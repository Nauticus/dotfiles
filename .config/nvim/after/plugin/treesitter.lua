local has_nvim_treesitter, treesitter = pcall(require, "nvim-treesitter")
if not has_nvim_treesitter then
    vim.notify("nvim-treesitter is missing", vim.log.levels.WARN)
    return
end

local parsers = require "nvim-treesitter.parsers"
local query = require "nvim-treesitter.query"

local foldmethod_backups = {}
local foldexpr_backups = {}

treesitter.define_modules {
    folding = {
        enable = true,
        attach = function(bufnr)
            -- Fold settings are actually window based...
            foldmethod_backups[bufnr] = vim.wo.foldmethod
            foldexpr_backups[bufnr] = vim.wo.foldexpr
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
        end,
        detach = function(bufnr)
            vim.wo.foldmethod = foldmethod_backups[bufnr]
            vim.wo.foldexpr = foldexpr_backups[bufnr]
            foldmethod_backups[bufnr] = nil
            foldexpr_backups[bufnr] = nil
        end,
        is_supported = query.has_folds,
    },
}

if pcall(require, "orgmode") then
    require("orgmode").setup_ts_grammar()
end

local filetype_to_parsername = parsers.filetype_to_parsername

filetype_to_parsername.javascript = "typescript"
filetype_to_parsername.css = "scss"

require("nvim-treesitter.configs").setup {
    ensure_installed = "all",
    ignore_install = { "javascript", "css", "haskell", "pug", "phpdoc" },
    highlight = {
        enable = true,
        disable = { "org", "pug" },
        additional_vim_regex_highlighting = { "pug" },
    },
    refactor = { highlight_definitions = { enable = true } },
    -- tree_docs = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "gn[",
            scope_incremental = "gn]",
            node_decremental = "gn)",
        },
    },
    textobjects = {
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
                ["adf"] = "@field",
            },
        },
    },
    autotag = { enable = true },
    matchup = { enable = true, include_match_words = true },
    context_commentstring = { enable = true },
    indent = { enable = true },
    playground = {
        enable = true,
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
    },
}
