local lsp = vim.lsp
local handlers = lsp.handlers
local notify = require "notify"

local show_message_handler = function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({
        "ERROR",
        "WARN",
        "INFO",
        "DEBUG",
    })[result.type]
    notify({ result.message }, lvl, {
        title = "LSP | " .. client.name,
        timeout = 10000,
        keep = function()
            return lvl == "ERROR" or lvl == "WARN"
        end,
    })
end

local pop_opts = { border = "single", max_width = 80 }

local setup_diagnostic_signs = function(signs)
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

local publish_diagnostics_handler = lsp.with(
    lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = false }
)

local signature_help_handler = lsp.with(handlers.signature_help, pop_opts)

setup_diagnostic_signs { Error = "", Warn = "", Hint = "", Info = "" }

vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(0, { scope = "cursor", source = "always", max_width = 120, focusable = false, header = "   Diagnostics:" })]]

local on_attach = function(client, bufnr)
    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.opt_local.tagfunc = "v:lua.vim.lsp.tagfunc"
    vim.opt_local.formatexpr = "v:lua.vim.lsp.formatexpr()"

    require("config.mappings").lsp_mappings(client, bufnr)

    handlers["textDocument/publishDiagnostics"] = publish_diagnostics_handler
    handlers["textDocument/signatureHelp"] = signature_help_handler
    handlers["window/showMessage"] = show_message_handler
end

return on_attach
