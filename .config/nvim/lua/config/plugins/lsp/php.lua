local on_attach = require('config.plugins.lsp.attach')

require'lspconfig'.phpactor.setup {on_attach = on_attach}
