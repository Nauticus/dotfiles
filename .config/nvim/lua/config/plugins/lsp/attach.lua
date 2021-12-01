local lsp = vim.lsp
local handlers = lsp.handlers

local pop_opts = { border = "single", max_width = 80 }

local setup_diagnostic_signs = function()
    local signs = { Error = "", Warn = "", Hint = "", Info = "" }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

local publish_diagnostics_handler = lsp.with(lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

local signature_help_handler = lsp.with(handlers.signature_help, pop_opts)

setup_diagnostic_signs()

vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(0, { scope = "cursor", source = "always", max_width = 120, focusable = false, border = "single", header = "   Diagnostics:" })]]

local on_attach = function(client, bufnr)
    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.opt_local.tagfunc = "v:lua.vim.lsp.tagfunc"
    vim.opt_local.formatexpr = "v:lua.vim.lsp.formatexpr()"

    require("config.plugins.lsp.mappings").setup(client, bufnr)

    handlers["textDocument/publishDiagnostics"] = publish_diagnostics_handler
    handlers["textDocument/signatureHelp"] = signature_help_handler
end

return on_attach
