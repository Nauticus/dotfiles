local lsp_config = require('lspconfig')
local on_attach = require('config.plugins.lsp.attach')

lsp_config.json.setup {
    on_attach = on_attach,
    settings = {
        json = {
            schemaDownload = { enable = true },
            schemas = {
                { fileMatch = { "/package.json" }, url = "https://json.schemastore.org/package.json" },
                { fileMatch = { "/babelrc.json" }, url = "https://json.schemastore.org/babelrc.json" },
                { fileMatch = { "/.eslintrc.json" }, url = "https://json.schemastore.org/eslintrc.json" },
                { fileMatch = { "/.prettierrc.json" }, url = "https://json.schemastore.org/prettierrc.json" },
                { fileMatch = { "/tsconfig.json" }, url = "https://json.schemastore.org/tsconfig.json" },
                { fileMatch = { "/jsconfig.json" }, url = "https://json.schemastore.org/jsconfig.json" }
            }
        }
    },
    filetypes = { "json" }
}
