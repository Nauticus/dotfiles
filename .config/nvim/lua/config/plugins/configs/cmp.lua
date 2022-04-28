local cmp = require "cmp"
local luasnip = require "luasnip"
local types = require "luasnip.util.types"

local tabnine = require "cmp_tabnine.config"

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

tabnine:setup {
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
}

luasnip.config.set_config {
    history = true,
    ext_opts = {
        [types.choiceNode] = { active = { virt_text = { { "", "GitSignsAdd" } } } },
        [types.insertNode] = { active = { virt_text = { { "", "GitSignsChange" } } } },
    },
}

require("luasnip.loaders.from_vscode").lazy_load()

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s"
            == nil
end

if not pcall(require, "nvim-autopairs.completion.cmp") then
    cmp.event:on(
        "confirm_done",
        require("nvim-autopairs.completion.cmp").on_confirm_done { map_char = { text = "" } }
    )
end

---@diagnostic disable-next-line: redundant-parameter
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sortings = {
        comparators = {
            cmp.config.compare.locally,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.compare.scopes,
            cmp.config.compare.offset,
            cmp.config.compare.order,
        },
    },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            return vim_item
        end,
    },
    sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "luasnip" },
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
    experimental = { native_menu = false, ghost_text = true },
    mapping = {
        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s", "c" }),

        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s", "c" }),
        ["<C-y>"] = cmp.mapping {
            i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace },
            c = cmp.mapping.confirm { select = false },
        },
    },
}

cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })
cmp.setup.cmdline("?", { sources = { { name = "buffer" } } })
