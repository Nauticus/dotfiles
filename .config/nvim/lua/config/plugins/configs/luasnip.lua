local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
    history = true,
    enable_autosnippets = false,
    region_check_events = "CursorHold",
    delete_check_events = "TextChanged",
    ext_opts = {
        [types.choiceNode] = { active = { virt_text = { { "﨧C", "NonText" } } } },
        [types.insertNode] = { active = { virt_text = { { "諸I", "NonText" } } } },
    },
}

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load()
