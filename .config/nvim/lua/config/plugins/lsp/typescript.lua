local lsp_config = require('lspconfig')
local on_attach = require('config.plugins.lsp.attach')

lsp_config.tsserver.setup {
    on_attach = on_attach,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = require('lspconfig/util').root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    settings = { documentFormatting = false }
}
