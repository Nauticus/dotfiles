local null_ls = require "null-ls"

local sources = {
    null_ls.builtins.formatting.prettier.with { prefer_local = "node_modules/.bin" },
    null_ls.builtins.formatting.eslint.with { prefer_local = "node_modules/.bin" },
    null_ls.builtins.formatting.stylua,
}

require("null-ls").setup {
    sources = sources,
    debug = true,
    on_attach = function(client, bufnr)
        require("config.mappings").lsp_mappings(client, bufnr)
    end,
}
