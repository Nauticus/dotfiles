return {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    build = "make install_jsregexp",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local luasnip = require("luasnip")
        local types = require("luasnip.util.types")

        luasnip.config.set_config({
            history = true,
            enable_autosnippets = false,
            update_events = "TextChanged,TextChangedI",
            region_check_events = "CursorHold",
            delete_check_events = "TextChanged",
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { "﨧Choice", "NonText" } },
                    },
                },
                [types.insertNode] = {
                    active = {
                        virt_text = { { "諸Insert", "NonText" } },
                    },
                },
            },
        })

        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").load()
    end,
}
