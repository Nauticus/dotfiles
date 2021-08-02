local lsp_config = require('lspconfig')
local on_attach = require('config.plugins.lsp.attach')

lsp_config.vuels.setup {
    on_attach = on_attach,
    settings = {
        vetur = {
            validation = { template = true, script = true, style = true, templateProps = true, interpolation = true },
            experimental = { templateInterpolationService = false }
        }
    }
}
