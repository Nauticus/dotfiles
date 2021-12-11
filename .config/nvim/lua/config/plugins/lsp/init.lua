local lsp_installer = require("nvim-lsp-installer")
local on_attach = require("config.plugins.lsp.attach")
local efm = require("config.plugins.lsp.efm")

local config = {
    vuels = {
        flags = { debounce_text_changes = 500 },
        init_options = {
            config = {
                vetur = {
                    useWorkspaceDependencies = true,
                    validation = { templateProps = true },
                    experimental = { templateInterpolationService = false }
                }
            }
        }
    },
    tsserver = {
        init_options = require("nvim-lsp-ts-utils").init_options,
        on_attach = function(client, bufnr)
            local ts_utils = require("nvim-lsp-ts-utils")

            ts_utils.setup({ inlay_hints_highlight = "TSLspInlayHints" })
            ts_utils.setup_client(client)

            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false

            on_attach(client, bufnr)
        end
    },
    efm = {
        filetypes = {
            "markdown",
            "yaml",
            "lua",
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescript.tsx",
            "typescriptreact",
            "vue"
        },
        init_options = { documentFormatting = true, codeAction = true },
        settings = {
            rootMarkers = efm.efm_root_markers,
            languages = {
                lua = { efm.lua_format },
                yaml = { efm.prettier },
                markdown = { efm.prettier },
                javascript = { efm.eslint_and_prettier },
                javascriptreact = { efm.eslint_and_prettier },
                typescript = { efm.eslint_and_prettier },
                typescriptreact = { efm.eslint_and_prettier },
                vue = { efm.eslint_and_prettier }
            }
        }
    },
    json = {
        settings = {
            json = {
                schemaDownload = { enable = true },
                schemas = {
                    { fileMatch = { "/package.json" }, url = "https://json.schemastore.org/package.json" },
                    { fileMatch = { "/babelrc.json" }, url = "https://json.schemastore.org/babelrc.json" },
                    { fileMatch = { "/.eslintrc.json" }, url = "https://json.schemastore.org/eslintrc.json" },
                    { fileMatch = { "/.prettierrc.json" }, url = "https://json.schemastore.org/prettierrc.json" },
                    { fileMatch = { "/tsconfig.json" }, url = "https://json.schemastore.org/tsconfig.json" },
                    { fileMatch = { "/jsconfig.json" }, url = "https://json.schemastore.org/jsconfig.Json" }
                }
            }
        }
    },
    sumneko_lua = require("lua-dev").setup {
        lspconfig = {
            flags = { debounce_text_changes = 300 },
            settings = { Lua = { diagnostics = { workspaceRate = "60" } } }
        }
    },
    eslint = { flags = { debounce_text_changes = 500 } }
}

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach,
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }

    if config[server.name] then
        opts = vim.tbl_extend("force", opts, config[server.name])
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/ADVANCED_README.md
    server:setup(opts)
end)
