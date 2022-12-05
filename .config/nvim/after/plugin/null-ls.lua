local has_null_ls, null_ls = pcall(require, "null-ls")
if not has_null_ls then
    vim.notify("null-ls is missing", vim.log.levels.WARN)
    return
end

local has_format_installer, format_installer = pcall(require, "format-installer")
if not has_format_installer then
    vim.notify("format-installer is missing", vim.log.levels.WARN)
    return
end

local sources = {
    null_ls.builtins.code_actions.gitsigns
}

for _, formatter in ipairs(format_installer.get_installed_formatters()) do
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
