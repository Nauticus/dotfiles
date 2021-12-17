local lsp_installer = require "nvim-lsp-installer"
local on_attach = require "config.plugins.lsp.attach"

local config = {
    vuels = {
        flags = { debounce_text_changes = 500 },
        init_options = {
            config = {
                vetur = {
                    useWorkspaceDependencies = true,
                    validation = { templateProps = true },
                    experimental = { templateInterpolationService = false },
                },
            },
        },
    },
    tsserver = {
        init_options = require("nvim-lsp-ts-utils").init_options,
        on_attach = function(client, bufnr)
            local ts_utils = require "nvim-lsp-ts-utils"

            ts_utils.setup { inlay_hints_highlight = "TSLspInlayHints" }
            ts_utils.setup_client(client)

            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false

            on_attach(client, bufnr)
        end,
    },
    jsonls = {
        filetypes = { "json", "jsonc" },
        settings = {
            json = {
                schemaDownload = { enable = true },
                schemas = require("schemastore").json.schemas(),
            },
        },
    },
    sumneko_lua = require("lua-dev").setup {
        lspconfig = {
            flags = { debounce_text_changes = 300 },
            settings = { Lua = { diagnostics = { workspaceRate = "60" } } },
        },
    },
    eslint = { flags = { debounce_text_changes = 500 } },
}

require "config.plugins.lsp.null-ls"

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        capabilities = require("cmp_nvim_lsp").update_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        ),
    }

    if server.name == "jsonls" then
        opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
    end

    if config[server.name] then
        opts = vim.tbl_extend("force", opts, config[server.name])
    end

    server:setup(opts)
end)
