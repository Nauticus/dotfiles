local on_attach = require('config.plugins.lsp.attach')

require'lspconfig'.intelephense.setup {on_attach = on_attach}
