local lsp_installer = require "nvim-lsp-installer"
local lspconfig = require "lspconfig"

local function get_message_level(type)
    return ({ "ERROR", "WARN", "INFO", "DEBUG" })[type]
end

local function on_attach(client, bufnr)
    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.opt_local.tagfunc = "v:lua.vim.lsp.tagfunc"
    vim.opt_local.formatexpr = "v:lua.vim.lsp.formatexpr()"

    require("config.core.mappings").lsp(client, bufnr)

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = false }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
        max_width = 80,
    })

    vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
        local context_client = vim.lsp.get_client_by_id(ctx.client_id)
        local level = get_message_level(result.type)
        local notify = require "notify"

        notify({ result.message }, level, {
            title = "LSP | " .. context_client.name,
            timeout = 10000,
            keep = function()
                return level == "ERROR" or level == "WARN"
            end,
        })
    end
end

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

            ts_utils.setup { auto_inlay_hints = false }
            ts_utils.setup_client(client)

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
        runtime_path = true,
    },
    eslint = { flags = { debounce_text_changes = 500 } },
}

lsp_installer.setup {}

local setup_server = function(server)
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

    lspconfig[server.name].setup(opts)
end

for _, server in ipairs(require("nvim-lsp-installer.servers").get_installed_servers()) do
    setup_server(server)
end
