local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        {
            "williamboman/mason-lspconfig.nvim",
            opts = {
                ensure_installed = { "lua_ls", "tsserver", "jsonls", "eslint" },
            },
            dependencies = {
                "williamboman/mason.nvim",
                config = function()
                    require("mason").setup({
                        ui = {
                            border = "single",
                        },
                    })
                end,
            },
        },
        "b0o/schemastore.nvim",
        "folke/neodev.nvim",
        "jose-elias-alvarez/nvim-lsp-ts-utils",
        "hrsh7th/cmp-nvim-lsp",
        -- Lsp
        { "j-hui/fidget.nvim", config = true },
    },
}

vim.diagnostic.config({
    float = {
        border = "single",
        source = "always",
    },
})

local mappings = function(client, bufnr)
    local keymap = vim.keymap
    local wk = require("which-key")
    local pickers = require("telescope.builtin")
    local capabilities = client.server_capabilities

    wk.register({ name = "+lsp", g = "+goto", w = "+workspaces" }, { prefix = "<leader>l" })

    local show_line_diagnostics = function()
        vim.diagnostic.open_float({
            scope = "line",
            source = "always",
            max_width = 120,
            focusable = false,
            border = "rounded",
            header = "Line Diagnostics:",
        })
    end

    local lsp_formatting = function()
        vim.lsp.buf.format({
            filter = function(c)
                return c.name ~= "sumneko_lua"
            end,
            bufnr = bufnr,
        })
    end

    local list_workspaces = function()
        vim.pretty_print(vim.lsp.buf.list_workspace_folders())
    end

    -- Go to
    if capabilities.definitionProvider then
        keymap.set(
            "n",
            "<leader>lgd",
            pickers.lsp_definitions,
            { desc = "Go to definition", buffer = bufnr }
        )
    end
    if capabilities.declarationProvider then
        keymap.set(
            "n",
            "<leader>lgD",
            vim.lsp.buf.declaration,
            { desc = "Go to declaration", buffer = bufnr }
        )
    end
    if capabilities.implementationProvider then
        keymap.set(
            "n",
            "<leader>lgi",
            pickers.lsp_implementations,
            { desc = "Go to implementation", buffer = bufnr }
        )
    end
    if capabilities.typeDefinitionProvider then
        keymap.set(
            "n",
            "<leader>lgt",
            pickers.lsp_type_definitions,
            { desc = "Go to type definition", buffer = bufnr }
        )
    end
    if capabilities.referencesProvider then
        keymap.set(
            "n",
            "<leader>lgr",
            pickers.lsp_references,
            { desc = "Go to reference", buffer = bufnr }
        )
    end

    -- Lsp specific
    if capabilities.signatureHelpProvider then
        keymap.set(
            "n",
            "<leader>ls",
            vim.lsp.buf.signature_help,
            { desc = "Show signature help", buffer = bufnr }
        )
    end
    if capabilities.renameProvider then
        keymap.set(
            "n",
            "<leader>lr",
            vim.lsp.buf.rename,
            { desc = "Rename symbol under cursor", buffer = bufnr }
        )
    end
    if capabilities.documentFormattingProvider then
        keymap.set("n", "<leader>lf", lsp_formatting, {
            desc = "Format",
            buffer = bufnr,
        })
    end
    -- if capabilities.documentRangeFormattingProvider then
    --     keymap.set("v", "<leader>lf", vim.lsp.buf.range_formatting, { desc = "Range format" })
    -- end
    if capabilities.codeActionProvider then
        keymap.set(
            "n",
            "<leader>la",
            vim.lsp.buf.code_action,
            { desc = "Code actions", buffer = bufnr }
        )
    end

    if capabilities.hoverProvider then
        keymap.set("n", "K", vim.lsp.buf.hover, {
            desc = "Hover",
            buffer = bufnr,
        })
    end

    keymap.set(
        "n",
        "<leader>ld",
        show_line_diagnostics,
        { desc = "Show line diagnostics", buffer = bufnr }
    )

    -- Workspaces
    keymap.set(
        "n",
        "<leader>lwa",
        vim.lsp.buf.add_workspace_folder,
        { desc = "Add workspace folder" }
    )
    keymap.set(
        "n",
        "<leader>lwr",
        vim.lsp.buf.remove_workspace_folder,
        { desc = "Remove workspace folder" }
    )
    keymap.set("n", "<leader>lwl", list_workspaces, { desc = "List workspace folders" })
end

local function on_attach(client, bufnr)
    mappings(client, bufnr)

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
        max_width = 80,
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
        max_width = 120,
    })
end

M.config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

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

                ts_utils.setup({ auto_inlay_hints = false })
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

    require("mason-lspconfig").setup_handlers({
        function(server_name)
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

            require("lspconfig")[server_name].setup(opts)
        end,
        ["lua_ls"] = function()
            local neodev = require("neodev")

            neodev.setup()

            require("lspconfig").lua_ls.setup({
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
        end,
    })
end

return M
