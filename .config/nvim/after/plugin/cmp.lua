local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then
    vim.notify("cmp is missing", vim.log.levels.WARN)
    return
end

local has_luasnip, luasnip = pcall(require, "luasnip")
if not has_luasnip then
    vim.notify("luasnip is missing", vim.log.levels.WARN)
    return
end

local has_tabnine, tabnine = pcall(require, "cmp_tabnine.config")
if has_tabnine then
    tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
    }
else
    vim.notify("cmp_tabnine.config is missing", vim.log.levels.WARN)
end

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

if not pcall(require, "nvim-autopairs.completion.cmp") then
    cmp.event:on(
        "confirm_done",
        require("nvim-autopairs.completion.cmp").on_confirm_done { map_char = { text = "" } }
    )
end

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

---@diagnostic disable-next-line: redundant-parameter
cmp.setup {
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

            vim_item.menu = string.format("[%s] %s", source, entry.source.score)
            vim_item.kind = kind_icons[vim_item.kind]

            return vim_item
        end,
    },
    sources = cmp.config.sources {
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
    },
    mapping = {
        ["<C-n>"] = cmp.mapping {
            i = mapping_next,
            s = mapping_next,
            c = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                else
                    fallback()
                end
            end,
        },
        ["<C-p>"] = cmp.mapping {
            i = mapping_prev,
            s = mapping_prev,
            c = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
                else
                    fallback()
                end
            end,
        },

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

        ["<C-y>"] = cmp.mapping {
            i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace },
            c = cmp.mapping.confirm { select = false },
        },

        ["<C-e>"] = cmp.mapping {
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
        },
    },
}

cmp.setup.filetype("harpoon", {
    sources = cmp.config.sources {
        { name = "path", priority_weight = 110 },
    },
})

cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })
cmp.setup.cmdline("?", { sources = { { name = "buffer" } } })
