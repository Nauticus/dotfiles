local has_ls, ls = pcall(require, "luasnip")
if not has_ls then
    vim.notify("luasnip is missing", vim.log.levels.WARN)
    return
end

local types = require "luasnip.util.types"

ls.config.set_config {
    history = true,
    enable_autosnippets = false,
    update_events = "TextChanged,TextChangedI",
    region_check_events = "CursorHold",
    delete_check_events = "TextChanged",
    ext_opts = {
        [types.choiceNode] = { active = { virt_text = { { "﨧C", "NonText" } } } },
        [types.insertNode] = { active = { virt_text = { { "諸I", "NonText" } } } },
    },
}

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load()
