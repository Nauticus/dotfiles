local parsers = require "nvim-treesitter.parsers"

local configs = parsers.get_parser_configs()

local parsers_filetypes = table.concat(
    vim.tbl_map(function(ft)
        return configs[ft].filetype or ft
    end, parsers.available_parsers()),
    ","
)

vim.cmd(
    "autocmd Filetype "
        .. parsers_filetypes
        .. " setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()"
)

vim.api.nvim_set_option("foldlevel", 10)

local parser_config = parsers.get_parser_configs()

parser_config.org = {
    install_info = {
        url = "https://github.com/milisims/tree-sitter-org",
        revision = "main",
        files = { "src/parser.c", "src/scanner.cc" },
    },
    filetype = "org",
}

parser_config.typescript.used_by = "javascript"
parser_config.scss.used_by = "css"

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
    ensure_installed = "maintained",
    ignore_install = { "javascript", "css", "haskell", "comment" },
    highlight = { enable = true, disable = { "org" }, additional_vim_regex_highlighting = false },
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
