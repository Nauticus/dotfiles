local has_null_ls, null_ls = pcall(require, "null-ls")
if not has_null_ls then
    vim.notify("null-ls is missing", vim.log.levels.WARN)
    return
end

local has_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")
if not has_mason_null_ls then
    vim.notify("mason-null-ls is missing", vim.log.levels.WARN)
    return
end

mason_null_ls.setup({
    ensure_installed = {"stylua", "prettier"}
})

local sources = {
    null_ls.builtins.code_actions.gitsigns
}

require 'mason-null-ls'.setup_handlers {
    function(source_name, methods)
      -- all sources with no handler get passed here
    end,
    stylua = function(source_name, methods)
      null_ls.register(null_ls.builtins.formatting.stylua)
    end,
}

-- will setup any installed and configured sources above
null_ls.setup {
    sources = sources,
    debug = true,
    --[[ on_attach = function(client, bufnr)
        require("config.core.mappings").lsp_mappings(client, bufnr)
    end, ]]
}
