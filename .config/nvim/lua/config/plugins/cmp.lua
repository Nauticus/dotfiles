local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "f3fora/cmp-spell",
        "hrsh7th/cmp-buffer",
        "andersevenrud/cmp-tmux",
        { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
        "rafamadriz/friendly-snippets",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "ray-x/cmp-treesitter",
        {
            "tzachar/cmp-tabnine",
            build = "./install.sh",
            opts = {
                max_lines = 1000,
                max_num_results = 20,
                sort = true,
                run_on_every_keystroke = true,
                snippet_placeholder = "..",
            },
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
            experimental = { native_menu = false, ghost_text = true },
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
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local source = ({
                        nvim_lsp = "LSP",
                        luasnip = "Snippet",
                        path = "Path",
                        cmp_tabnine = "Tabnine",
                        buffer = "Buffer",
                        tmux = "Tmux",
                    })[entry.source.name]

                    vim_item.menu = string.format("[%s]", source)
                    vim_item.kind = kind_icons[vim_item.kind]

                    return vim_item
                end,
            },
            window = {
                completion = {
                    border = border("CmpBorder"),
                },
                documentation = {
                    border = border("CmpDocBorder"),
                },
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip", priority_weight = 50 },
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lua" },
                { name = "path" },
                { name = "cmp_tabnine" },
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
                ["<Tab>"] = cmp.mapping({
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
                ["<S-Tab>"] = cmp.mapping({
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
