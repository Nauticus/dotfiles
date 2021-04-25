local lsp_config = require('lspconfig')
local on_attach = require('config.plugins.lsp.attach')

local efm_root_markers = { 'package.json', '.git/', '.zshrc' }

local prettier = { formatCommand = 'prettier --find-config-path --stdin-filepath ${INPUT}', formatStdin = true }

local eslint = {
    lintCommand = 'eslint_d --stdin --stdin-filename ${INPUT} -f unix',
    lintStdin = true,
    lintIgnoreExitCode = true
}

local lua_format = { formatCommand = "lua-format -i", formatStdin = true }

lsp_config.efm.setup {
    on_attach = on_attach,
    filetypes = {
        "markdown",
        "lua",
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescript.tsx",
        "typescriptreact"
    },
    init_options = { documentFormatting = true },
    settings = {
        rootMarkers = efm_root_markers,
        languages = {
            lua = { lua_format },
            markdown = { prettier },
            javascript = { eslint, prettier },
            javascriptreact = { eslint, prettier },
            typescript = { eslint, prettier },
            typescriptreact = { eslint, prettier }
        }
    }
}
