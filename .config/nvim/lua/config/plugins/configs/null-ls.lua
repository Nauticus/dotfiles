local null_ls = require "null-ls"
local formatter_install = require "format-installer"

local sources = {
    null_ls.builtins.code_actions.gitsigns
}

for _, formatter in ipairs(formatter_install.get_installed_formatters()) do
    local config = { command = formatter.cmd, prefer_local = "node_modules/.bin" }
    table.insert(sources, null_ls.builtins.formatting[formatter.name].with(config))
end

null_ls.setup {
    sources = sources,
    debug = true,
    --[[ on_attach = function(client, bufnr)
        require("config.core.mappings").lsp_mappings(client, bufnr)
    end, ]]
}
