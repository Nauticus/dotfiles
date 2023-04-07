return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "f3fora/cmp-spell",
        "hrsh7th/cmp-buffer",
        "andersevenrud/cmp-tmux",
        { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "ray-x/cmp-treesitter",
        {
            "tzachar/cmp-tabnine",
            build = "./install.sh",
            config = function()
                local tabnine = require("cmp_tabnine.config")

                tabnine:setup({
                    max_lines = 1000,
                    max_num_results = 20,
                    sort = true,
                    run_on_every_keystroke = true,
                    snippet_placeholder = "..",
                })
            end,
        },
        "hrsh7th/cmp-nvim-lua",
        "lukas-reineke/cmp-under-comparator",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-cmdline",
        "windwp/nvim-autopairs",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.event:on(
            "confirm_done",
            require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { text = "" } })
        )

        local mapping_next = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end

        local mapping_prev = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            view = {
                entries = "custom",
                selection_order = "near_cursor",
            },
            experimental = { native_menu = false, ghost_text = false },
            completion = {
                keyword_length = 1,
            },
            sortings = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    require("cmp-under-comparator").under,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            formatting = {
                fields = { "abbr", "menu", "kind" },
                format = function(entry, item)
                    local short_name = {
                        nvim_lsp = "LSP",
                        nvim_lua = "nvim",
                    }

                    local menu_name = short_name[entry.source.name] or entry.source.name

                    item.menu = string.format("[%s]", menu_name)
                    return item
                end,
            },
            window = {
                completion = cmp.config.window.bordered({
                    border = "single",
                    winhighlight = "Normal:Normal,FloatBorder:CmpCompletionWindow,CursorLine:Visual,Search:None",
                }),
                documentation = cmp.config.window.bordered({
                    border = "single",
                    winhighlight = "Normal:Normal,FloatBorder:CmpDocumentationWindow,CursorLine:Visual,Search:None",
                }),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "cmp_tabnine" },
                { name = "luasnip", priority_weight = 50 },
                { name = "nvim_lua" },
                { name = "path" },
            }, {
                {
                    name = "buffer",
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
                { name = "tmux", max_item_count = 10 },
            }),
            mapping = {
                ["<C-n>"] = cmp.mapping({
                    i = mapping_next,
                    s = mapping_next,
                    c = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end,
                }),
                ["<C-p>"] = cmp.mapping({
                    i = mapping_prev,
                    s = mapping_prev,
                    c = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end,
                }),

                ["<C-j>"] = cmp.mapping(function(fallback)
                    if luasnip.choice_active() then
                        luasnip.change_choice(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-k>"] = cmp.mapping(function(fallback)
                    if luasnip.choice_active() then
                        luasnip.change_choice(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<CR>"] = cmp.mapping({
                    i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
                    c = cmp.mapping.confirm({ select = false }),
                }),

                ["<C-c>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() then
                            cmp.abort()
                        else
                            fallback()
                        end
                    end,
                    c = function(fallback)
                        if cmp.visible() then
                            cmp.close()
                        else
                            fallback()
                        end
                    end,
                }),
            },
        })

        cmp.setup.filetype("harpoon", {
            sources = cmp.config.sources({
                { name = "path", priority_weight = 110 },
            }),
        })

        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline("?", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "cmdline" },
            },
        })
    end,
}
