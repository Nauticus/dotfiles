local has_nvim_treesitter, _ = pcall(require, "nvim-treesitter")
if not has_nvim_treesitter then
    vim.notify("nvim-treesitter is missing", vim.log.levels.WARN)
    return
end

-- local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local parsers = require "nvim-treesitter.parsers"
local configs = parsers.get_parser_configs()

local parsers_filetypes = vim.tbl_map(function(ft)
    return configs[ft].filetype or ft
end, parsers.available_parsers())

autocmd("Filetype", {
    pattern = parsers_filetypes,
    callback = function()
        vim.opt_local.foldmethod = "expr"
        vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    end
})

if pcall(require, "orgmode") then
    require("orgmode").setup_ts_grammar()
end

local filetype_to_parsername = parsers.filetype_to_parsername

filetype_to_parsername.javascript = "typescript"
filetype_to_parsername.css = "scss"

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
        },
    },
}

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
    incremental_selection = incremental_selection,
    textobjects = textobjects,
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

