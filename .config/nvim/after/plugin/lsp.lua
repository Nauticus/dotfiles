---@diagnostic disable: assign-type-mismatch
local has_lspconfig, lspconfig = pcall(require, "lspconfig")
if not has_lspconfig then
    vim.notify("lspconfig is missing", vim.log.levels.WARN)
    return
end

local has_mason, mason = pcall(require, "mason")
if not has_mason then
    vim.notify("mason is missing", vim.log.levels.WARN)
    return
end

local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not has_mason_lspconfig then
    vim.notify("mason-lspconfig is missing", vim.log.levels.WARN)
    return
end

local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not has_cmp_nvim_lsp then
    vim.notify("cmp_nvim_lsp is missing", vim.log.levels.WARN)
end

mason.setup()

mason_lspconfig.setup {
    ensure_installed = { "sumneko_lua", "tsserver", "jsonls", "eslint" }
}

local function on_attach(client, bufnr)
    local has_mappings, mappings = pcall(require, "config.core.mappings")
    if not has_mappings then
        vim.notify("config.core.mappings is missing", vim.log.levels.WARN)
        return
    end

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.opt_local.tagfunc = "v:lua.vim.lsp.tagfunc"
    vim.opt_local.formatexpr = "v:lua.vim.lsp.formatexpr()"

    mappings.lsp(client, bufnr)

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { virtual_text = false }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
        max_width = 80,
    })
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
            local has_ts_utils, ts_utils = pcall(require, "nvim-lsp-ts-utils")
            if not has_ts_utils then
                vim.notify("nvim-lsp-ts-utils is missing", vim.log.levels.WARN)
                return
            end

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
    eslint = { flags = { debounce_text_changes = 500 } },
}

mason_lspconfig.setup_handlers {
    function (server_name)
        local opts = {
            on_attach = on_attach,
            capabilities = cmp_nvim_lsp.default_capabilities(),
        }

        if server_name == "jsonls" then
            opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
        end

        if config[server_name] then
            opts = vim.tbl_extend("force", opts, config[server_name])
        end

        lspconfig[server_name].setup(opts)
    end,
    ["sumneko_lua"] = function ()
        local has_neodev, neodev = pcall(require, "neodev")
        if not has_neodev then
            vim.notify("neodev is missing", vim.log.levels.WARN)
            return
        end

        neodev.setup()

        lspconfig["sumneko_lua"].setup({
            on_attach = on_attach,
            capabilities = cmp_nvim_lsp.default_capabilities(),
            settings = {
                Lua = {
                    completion = {
                        callSnippet = "Replace",
                    },
                },
            },
        })
    end
}

local has_nvim_lightbulb, nvim_lightbulb = pcall(require, "nvim-lightbulb")
if has_nvim_lightbulb then
    nvim_lightbulb.setup {}
end

local has_fidget, fidget = pcall(require, "fidget")
if has_fidget then
    fidget.setup {}
end

local has_trouble, trouble = pcall(require, "trouble")
if has_trouble then
    trouble.setup {}
end
