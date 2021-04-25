local lsp_config = require('lspconfig')
local on_attach = require('config.plugins.lsp.attach')

lsp_config.tsserver.setup {on_attach = on_attach}
