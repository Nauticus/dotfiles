local lspconfig = require('lspconfig')
local on_attach = require('config.plugins.lsp.attach')
local null_ls = require('null-ls')

local prettier = require("null-ls.helpers").conditional(function(utils)
    local project_local_bin = "node_modules/.bin/prettier"

    return null_ls.builtins.formatting.prettier.with({
        command = utils.root_has_file(project_local_bin) and project_local_bin or "prettier"
    })
end)

local eslint_diagnostics = require('null-ls.helpers').conditional(
                               function(utils)
        local project_local_bin = "node_modules/.bin/eslint"

        return null_ls.builtins.diagnostics.eslint.with({
            command = utils.root_has_file(project_local_bin) and project_local_bin or "eslint",
            diagnostics_format = "[#{c}] #{m} (#{s})"
        })
    end)


local eslint_formatter = require('null-ls.helpers').conditional(
                             function(utils)
        local project_local_bin = "node_modules/.bin/eslint"

        return null_ls.builtins.formatting.eslint.with({
            command = utils.root_has_file(project_local_bin) and project_local_bin or "eslint"
        })
    end)

local sources = {
    eslint_diagnostics,
    eslint_formatter,
    prettier,
    null_ls.builtins.formatting.lua_format
}

require("null-ls").config({ debug = true, sources = sources })

lspconfig["null-ls"].setup({ on_attach = on_attach, capabilities = require('config.plugins.lsp.capabilities') })
